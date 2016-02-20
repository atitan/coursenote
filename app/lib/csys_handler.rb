require 'net/http'
require 'openssl'
require 'json'

class CsysHandler
  def initialize(student_id, password)
    @student_id = student_id
    @password = password
    @http = Net::HTTP.new('csys.cycu.edu.tw')
    @headers = {}
    @loggedin = false
    init_cookie
  end

  def login
    return false if @loggedin

    resp = @http.post('/sso/sso.srv', "cmd=login&userid=#{@student_id}&hash=#{login_hash}", @headers)
    resp_json = JSON.parse(resp.body)

    raise resp_json['message'] unless resp_json['result']

    @headers['Page-Id'] = resp_json['pageId']
    @loggedin = true
  end

  def logout
    return false unless @loggedin
    @http.post('/sso/sso.srv', 'cmd=logout', @headers)
    @loggedin = false
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
    resp = @http.get('/index.jsp')
    raw_cookies = resp.response['set-cookie']

    cookies = []
    raw_cookies.split(/, ?/).each do |raw_cookie|
      cookies << raw_cookie.split(';')[0]
    end

    @headers['Cookie'] = cookies.join(';')
  end

  def secure_random
    resp = @http.post('/sso/sso.srv', 'cmd=login_init', @headers)
    resp_json = JSON.parse(resp.body)
    resp_json['secureRandom']
  end

  def login_hash
    OpenSSL::HMAC.hexdigest('sha256', @password, @student_id + secure_random)
  end
end
