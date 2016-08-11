require 'rails_helper'

RSpec.feature "Signing In", type: :feature do
  background do
    User.create(email: 'miho@cycu.edu.tw', password: 'Panzer Vor!').confirm
    User.create(email: 'yukari@cycu.edu.tw', password: 'ヒヤッホォォォウ！最高だぜぇぇぇぇ')
  end

  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in '學校信箱', with: 'miho@cycu.edu.tw'
      fill_in '密碼', with: 'Panzer Vor!'
    end
    click_button '送出'
    expect(page).to have_content '成功登入了'
  end

  scenario "Signing in with wrong credentials" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in '學校信箱', with: '赤座'
      fill_in '密碼', with: '\アッカリ〜ン/'
    end
    click_button '送出'
    expect(page).to have_content '信箱或密碼是無效的'
  end

  scenario "Signing in with unconfirmed account" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in '學校信箱', with: 'yukari@cycu.edu.tw'
      fill_in '密碼', with: 'ヒヤッホォォォウ！最高だぜぇぇぇぇ'
    end
    click_button '送出'
    expect(page).to have_content '需要經過驗證'
  end
end
