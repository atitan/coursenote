# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :course do
    title '宗教哲學'
    category '天'
    instructor '王大明'
    available true
    score { (-10..10).to_a.shuffle.first }
  end

  factory :entry do
    course
    code 'AB1234Z'
    credit 3
    department '通識'
    timetable {{'1' => ['3', '4']}}
    timestring '1-34'
    cross_department false
    cross_graduate false
    quittable false
    required true
    note '不能停修'
  end

  factory :comment do
    course
    parent
    user
    score { (-10..10).to_a.shuffle.first }
    content 'This is a comment'
  end

  factory :user do
    sequence(:email) { |n| "s#{(10200000 + n).to_s}@cycu.edu.tw" }
  end

  factory :vote do
    user
    votable
  end
end
