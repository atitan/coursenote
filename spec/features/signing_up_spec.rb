require 'rails_helper'

RSpec.feature "Signing Up", type: :feature do
  scenario "Signing up with correct inputs" do
    visit '/users/sign_up'
    within("#new_user") do
      fill_in '學校信箱', with: 'saori@cycu.edu.tw'
      fill_in '密碼', with: 'パンツのアホぉ～～！？'
      fill_in '確認密碼', with: 'パンツのアホぉ～～！？'
    end
    click_button '送出'
    expect(page).to have_content '確認信件已送至您的 Email 信箱'
  end

  scenario "Signing up with non cycu email" do
    visit '/users/sign_up'
    within("#new_user") do
      fill_in '學校信箱', with: 'Darjeeling@St.Gloriana.Girls.Academy'
      fill_in '密碼', with: 'こんな格言を知ってる？'
      fill_in '確認密碼', with: 'こんな格言を知ってる？'
    end
    click_button '送出'
    expect(page).to have_content 'Email 是無效的'
  end
end
