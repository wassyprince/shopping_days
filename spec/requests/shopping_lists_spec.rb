require 'rails_helper'

RSpec.describe "ShoppingLists", type: :request do
  let(:user) { User.create!(name: 'test', email: 'test@example.com', password: '000000') }

  before do
    sign_in user
  end

  describe "GET /shopping_lists" do
    it "一覧ページが表示される" do
      get shopping_lists_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /shopping_lists" do
    it "新しいリストを作成できる" do
      expect {
        post shopping_lists_path, params: { shopping_list: { title: "牛乳とパン", date: Date.today, user_id: user.id } }
      }.to change(ShoppingList, :count).by(1)
    end
  end

  describe "PATCH /shopping_lists/:id" do
  let!(:list) { ShoppingList.create!(title: "古いタイトル", date: Date.today, user: user) }

    it "タイトルを更新できる" do
      patch shopping_list_path(list), params: { shopping_list: { title: "新しいタイトル" } }
      expect(response).to have_http_status(:found) # 成功後にリダイレクトされるはず
      list.reload
      expect(list.title).to eq("新しいタイトル")
    end
  end

  describe "DELETE /shopping_lists/:id" do
  let!(:list) { ShoppingList.create!(title: "削除対象", date: Date.today, user: user) }

    it "リストを削除できる" do
      expect {
        delete shopping_list_path(list)
      }.to change(ShoppingList, :count).by(-1)
      expect(response).to have_http_status(:found) # 削除後にリダイレクトされるはず
    end
  end
end