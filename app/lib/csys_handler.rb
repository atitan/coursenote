require 'net/http'
require 'openssl'
require 'json'

class CsysHandler
  def initialize(student_id, password)
    @student_id = student_id
    @password = password
    @http = Net::HTTP.new('csys.cycu.edu.tw')
    @headers = {'Referer' => 'http://csys.cycu.edu.tw/student/', 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.82 Safari/537.36'}
    @loggedin = false
    init_cookie
  end

  def login
    return false if @loggedin

    resp = @http.post('/student/sso.srv', "cmd=login&userid=#{@student_id}&hash=#{login_hash}", @headers)
    resp_json = JSON.parse(resp.body)

    raise resp_json['message'] unless resp_json['result']

    @headers['Page-Id'] = resp_json['pageId']
    @loggedin = true
  end

  def logout
    return false unless @loggedin
    @http.post('/student/sso.srv', 'cmd=logout', @headers)
    @loggedin = false
    true
  end

  def fetch_class_schedule
    return false unless @loggedin
    path = '/student/op/StudentCourseTime.srv'

    resp = @http.post(path, "cmd=selectJson&where=idcode%3D'#{@student_id}'", @headers)
    resp_json = JSON.parse(resp.body)

    raise resp_json['message'] unless resp_json['datas']

    time = {}
    resp_json['datas'].each do |data|
      (time[data['week_day']] ||= []) << data['sess']
    end

    time
  end

  def bookmark(list = [])
    return false unless @loggedin
    path = '/student/op/StudentCourseTrace.srv'

    list.each do |item|
      @http.post(path, "cmd=insert&op_code=#{item}", @headers)
    end
  end

  private

  def init_cookie
    resp = @http.get('/student/index.jsp', @headers)
    raw_cookies = resp.response['set-cookie']

    cookies = []
    raw_cookies.split(/, ?/).each do |raw_cookie|
      cookies << raw_cookie.split(';')[0]
    end

    @headers['Cookie'] = cookies.join(';')
  end

  def secure_random
    resp = @http.post('/student/sso.srv', 'cmd=login_init', @headers)
    resp_json = JSON.parse(resp.body)
    resp_json['secureRandom']
  end

  def login_hash
    hashed_passwd = OpenSSL::Digest::MD5.hexdigest(@password)
    OpenSSL::HMAC.hexdigest('sha256', hashed_passwd, @student_id + secure_random)
  end
end
