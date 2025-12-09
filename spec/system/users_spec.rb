require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { User.create!(name: "test", email: "test@example.com", password: "000000") }

  it "ユーザーがログインできる" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "000000"
    click_button "Log in"

    expect(page).to have_content("ログインしました")
  end
end