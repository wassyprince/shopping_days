require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '予定作成' do
    context '正常系' do
      it '正しい値なら登録できる' do
        plan = Plan.new(title: 'テスト予定', start_time: Time.current, end_time: Time.current + 1.hour)
        expect(plan).to be_valid
      end
    end

    context '異常系' do
      it 'titleが空では登録できない' do
        plan = Plan.new(title: '', start_time: Time.current, end_time: Time.current + 1.hour)
        plan.valid?
        expect(plan.errors.full_messages).to include("タイトルを入力してください")
      end

      it 'start_timeが空では登録できない' do
        plan = Plan.new(title: 'テスト予定', start_time: nil, end_time: Time.current + 1.hour)
        plan.valid?
        expect(plan.errors.full_messages).to include("開始時間を入力してください")
      end

      it 'end_timeが空では登録できない' do
        plan = Plan.new(title: 'テスト予定', start_time: Time.current, end_time: nil)
        plan.valid?
        expect(plan.errors.full_messages).to include("終了時間を入力してください")
      end

      it 'end_timeがstart_timeより前だと登録できない' do
        plan = Plan.new(title: 'テスト予定', start_time: Time.current, end_time: Time.current - 1.hour)
        plan.valid?
        expect(plan.errors.full_messages).to include("終了時間は開始時間より後にしてください")
      end
    end
  end
end
