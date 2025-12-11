require 'rails_helper'

RSpec.describe EditHistory, type: :model do
  describe '編集履歴作成' do
    context '正常系' do
      it '正しい値なら登録できる' do
        user = User.create!(name: 'test', email: 'test@example.com', password: '000000')
        shopping_list = ShoppingList.create!(date: Date.today, title: '買い物', user: user)
        history = EditHistory.new(user: user, shopping_list: shopping_list, action: 'created',  after_name: 'りんご', after_category: 'フルーツ')
        expect(history).to be_valid
      end
    end

    context '異常系' do
      it 'userがnilでは登録できない' do
        shopping_list = ShoppingList.create!(date: Date.today, title: '買い物', user: User.create!(name: 'test', email: 'test@example.com', password: '000000'))
        history = EditHistory.new(user: nil, shopping_list: shopping_list, action: 'created')
        history.valid?
        expect(history.errors.full_messages).to include("Userを入力してください")
      end

      it 'shopping_listがnilでは登録できない' do
        user = User.create!(name: 'test', email: 'test@example.com', password: '000000')
        history = EditHistory.new(user: user, shopping_list: nil, action: 'created')
        history.valid?
        expect(history.errors.full_messages).to include("Shopping listを入力してください")
      end
    end
  end
end
