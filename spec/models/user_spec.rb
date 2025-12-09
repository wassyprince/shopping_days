require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '正常系' do
      it '正しい値なら登録できる' do
        user = User.new(name: 'test', email: 'test@example.com', password: '000000', password_confirmation: '000000')
        expect(user).to be_valid
      end
    end

    context '異常系' do
      context 'name' do
        it '空では登録できない' do
          user = User.new(name: '', email: 'test@example.com', password: '000000', password_confirmation: '000000')
          user.valid?
          expect(user.errors.full_messages).to include("Nameを入力してください")
        end
      end

      context 'email' do
        it '空では登録できない' do
          user = User.new(name: 'test', email: '', password: '000000', password_confirmation: '000000')
          user.valid?
          expect(user.errors.full_messages).to include("Emailを入力してください")
        end

        it '@が含まれていないと登録できない' do
          user = User.new(name: 'test', email: 'testexample.com', password: '000000', password_confirmation: '000000')
          user.valid?
          expect(user.errors.full_messages).to include("Emailは不正な値です")
        end

        it '重複していると登録できない' do
          User.create!(name: 'test1', email: 'test@example.com', password: '000000', password_confirmation: '000000')
          user = User.new(name: 'test2', email: 'test@example.com', password: '000000', password_confirmation: '000000')
          user.valid?
          expect(user.errors.full_messages).to include("Emailはすでに存在します")
        end
      end

      context 'password' do
        it '空では登録できない' do
          user = User.new(name: 'test', email: 'test@example.com', password: '', password_confirmation: '')
          user.valid?
          expect(user.errors.full_messages).to include("Passwordを入力してください")
        end

        it '6文字未満では登録できない' do
          user = User.new(name: 'test', email: 'test@example.com', password: '12345', password_confirmation: '12345')
          user.valid?
          expect(user.errors.full_messages).to include("Passwordは6文字以上で入力してください")
        end
      end
    end
  end
end