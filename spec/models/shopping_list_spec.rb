require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  describe '買い物リスト作成' do
    context '正常系' do
      it '正しい値なら登録できる' do
        shopping_list = ShoppingList.new(date: Date.today, title: '買い物リスト', user: User.new)
        expect(shopping_list).to be_valid
      end
    end

    context '異常系' do
      it 'dateが空では登録できない' do
        shopping_list = ShoppingList.new(date: nil, title: '買い物リスト', user: User.new)
        shopping_list.valid?
        expect(shopping_list.errors.full_messages).to include("Dateを入力してください")
      end

      it 'titleが空では登録できない' do
        shopping_list = ShoppingList.new(date: Date.today, title: '', user: User.new)
        shopping_list.valid?
        expect(shopping_list.errors.full_messages).to include("リスト名を入力してください")
      end
    end
  end
end
