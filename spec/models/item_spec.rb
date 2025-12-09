require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'アイテム作成' do
    context '正常系' do
      it '正しい値なら登録できる' do
        item = Item.new(name: 'りんご', quantity: 3, category: '食品', shopping_list: ShoppingList.new(date: Date.today, title: '買い物', user: User.new))
        expect(item).to be_valid
      end
    end

    context '異常系' do
      it 'nameが空では登録できない' do
        item = Item.new(name: '', quantity: 1, category: '食品', shopping_list: ShoppingList.new(date: Date.today, title: '買い物', user: User.new))
        item.valid?
        expect(item.errors.full_messages).to include("名前を入力してください")
      end

      it 'quantityが空では登録できない' do
        item = Item.new(name: 'りんご', quantity: nil, category: '食品', shopping_list: ShoppingList.new(date: Date.today, title: '買い物', user: User.new))
        item.valid?
        expect(item.errors.full_messages).to include("数量は数値で入力してください")
      end

      it 'quantityが整数でないと登録できない' do
        item = Item.new(name: 'りんご', quantity: 1.5, category: '食品', shopping_list: ShoppingList.new(date: Date.today, title: '買い物', user: User.new))
        item.valid?
        expect(item.errors.full_messages).to include("数量は整数で入力してください")
      end

      it 'quantityが1未満だと登録できない' do
        item = Item.new(name: 'りんご', quantity: 0, category: '食品', shopping_list: ShoppingList.new(date: Date.today, title: '買い物', user: User.new))
        item.valid?
        expect(item.errors.full_messages).to include("数量は1以上の値にしてください")
      end

      it 'categoryが空では登録できない' do
        item = Item.new(name: 'りんご', quantity: 1, category: '', shopping_list: ShoppingList.new(date: Date.today, title: '買い物', user: User.new))
        item.valid?
        expect(item.errors.full_messages).to include("分類を入力してください")
      end
    end
  end
end
