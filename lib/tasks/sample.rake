require 'highline/import'
require 'open-uri'
require 'json'

namespace :sample do
  desc 'import sample account and comments into database'
  task :import, [:skip] => :environment do |task, args|
    puts '接下來，將導引您建立 Sample User，並隨機幫您建立 500 筆假留言。'

    puts '首先，將導引建立 Sample User 帳號，請依照指示進行'
    user = User.new
    user.email                    = args.skip ? 'test@cycu.edu.tw' : ask('請輸使用者的 Email：'){ |q| q.default = 'testing@cycu.edu.tw' }
    user.password                 = args.skip ? 'a12345678' : ask('請輸入使用者的 密碼：') {|q| q.echo = '*'}
    user.password_confirmation    = args.skip ? 'a12345678' : ask("請再次輸入使用者的 密碼 以供確認：") {|q| q.echo = '*'}
    user.save!
    user.confirm!

    puts  "\n接下來將隨機產生 500 則評論。"
    print 'Downloading Random Sentences...'
    random_sentences  = JSON.load(open 'http://more.handlino.com/sentences.json?n=100&limit=5,20')['sentences']
    random_sentences << JSON.load(open 'http://more.handlino.com/sentences.json?n=100&limit=5,20')['sentences']
    puts  'completed'

    percentage = 0

    Course.all.sample(800).each_with_index do |course, index|
      course.comments.create(user_id: user.id, score: (-50..50).to_a.sample, content: random_sentences.sample(10).join())
      current_percentage = (index * 100 / 800)
      if current_percentage > percentage
        percentage = current_percentage
        print "\rImporting Comments... #{percentage}% completed"
      end
    end

    puts  "\n接下來將隨機產生 1000 則回應。"
    percentage = 0
    1000.times do |index|
      comment = Comment.where(parent_id: nil).sample
      comment.replies.create(user_id: user.id, course_id: comment.course_id, score: (-50..50).to_a.sample, content: random_sentences.sample(10).join())
      current_percentage = (index * 100 / 1000)
      if current_percentage > percentage
        percentage = current_percentage
        print "\rImporting Replies... #{percentage}% completed"
      end
    end
  end
end
