# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :course do
    title '宗教哲學'
    category '天'
    instructor '王大明'
    available true
    score { (-10..10).to_a.shuffle.first }
  end  
end