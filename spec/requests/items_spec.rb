require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:user) { create(:user) }
  let(:list) { create(:shopping_list, user: user) }

  before { sign_in user }

  describe "POST /shopping_lists/:shopping_list_id/items" do
    context "valid params" do
      it "creates item and edit_history, then redirects" do
        post shopping_list_items_path(list), params: { item: { name: "りんご", quantity: 2, category: "食料品" } }

        expect(response).to redirect_to(list)
        follow_redirect!
        expect(response.body).to include("品物を追加しました")

        item = list.items.last
        history = EditHistory.last
        expect(history.action).to eq("created")
        expect(history.user).to eq(user)
        expect(history.shopping_list).to eq(list)
        expect(history.item).to eq(item)
        expect(history.after_name).to eq("りんご")
        expect(history.after_quantity).to eq(2)
        expect(history.after_category).to eq("食料品")
      end
    end

    context "invalid params" do
      it "renders show with 422 and no history" do
        post shopping_list_items_path(list), params: { item: { name: "", quantity: 2 } }
        expect(response).to have_http_status(422)
        expect(response.body).to include("品物の追加に失敗しました")
        expect(EditHistory.count).to eq(0)
      end
    end
  end

  describe "PATCH /shopping_lists/:shopping_list_id/items/:id" do
    let!(:item) { create(:item, shopping_list: list, name: "みかん", quantity: 1, category: "食料品", purchased: false) }

    it "updates item and records before/after" do
      patch shopping_list_item_path(list, item), params: { item: { name: "オレンジ", quantity: 3, category: "その他", purchased: true } }
      expect(response).to redirect_to(list)
      follow_redirect!
      expect(response.body).to include("品物を更新しました")

      history = EditHistory.last
      expect(history.action).to eq("updated")
      expect(history.before_name).to eq("みかん")
      expect(history.after_name).to eq("オレンジ")
      expect(history.before_quantity).to eq(1)
      expect(history.after_quantity).to eq(3)
      expect(history.before_category).to eq("食料品")
      expect(history.after_category).to eq("その他")
      expect(history.before_purchased).to eq(false)
      expect(history.after_purchased).to eq(true)
    end

    it "invalid update renders edit with 422 and no new history" do
      expect {
        patch shopping_list_item_path(list, item), params: { item: { name: "" } }
      }.not_to change(EditHistory, :count)
      expect(response).to have_http_status(422)
      expect(response.body).to include("品物の更新に失敗しました")
    end
  end

  describe "DELETE /shopping_lists/:shopping_list_id/items/:id" do
    let!(:item) { create(:item, shopping_list: list, name: "バナナ", quantity: 5, category: "食料品") }

    it "deletes item and records deleted history" do
      expect {
        delete shopping_list_item_path(list, item)
      }.to change(Item, :count).by(-1)
      expect(response).to redirect_to(list)
      follow_redirect!
      expect(response.body).to include("品物を削除しました")

      history = EditHistory.last
      expect(history.action).to eq("deleted")
      expect(history.before_name).to eq("バナナ")
      expect(history.before_quantity).to eq(5)
      expect(history.before_category).to eq("食料品")
    end
  end
end