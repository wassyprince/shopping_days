require 'rails_helper'

RSpec.describe "ShoppingLists", type: :system do
  let(:user) { User.create!(name: "test", email: "test@example.com", password: "000000") }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "000000"
    click_button "Log in"
  end

  it "カレンダーから買い物リストを新規作成できる" do
    visit calendar_path
    first(".day.today .add-button").click

    fill_in "リスト名", with: "牛乳とパン"
    click_button "買い物リストを作成"

    expect(page).to have_content("牛乳とパン")
  end

  it "買い物リストを編集できる" do
    visit calendar_path
    first(".add-button").click
    fill_in "リスト名", with: "りんご"
    click_button "買い物リストを作成"
    expect(page).to have_content("りんご")

    click_link "編集"
    fill_in "リスト名", with: "りんごとみかん"
    click_button "保存"

    expect(page).to have_content("りんごとみかん")
  end

  it "買い物リストを削除できる" do
    visit calendar_path
    first(".add-button").click
    fill_in "リスト名", with: "卵とバター"
    click_button "買い物リストを作成"
    expect(page).to have_content("卵とバター")

    click_link "削除"
    expect(page).not_to have_content("卵とバター")
  end
end