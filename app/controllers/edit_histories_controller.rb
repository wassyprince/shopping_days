class EditHistoriesController < ApplicationController
  def index
    @edit_histories = EditHistory.includes(:user, :shopping_list, :item).order(created_at: :desc)

     # 分類フィルタ
    if params[:category].present?
      @edit_histories = @edit_histories.where(items: { category: params[:category] })
    end

    # 日付フィルタ
    if params[:date].present?
      date = Date.parse(params[:date])
      @edit_histories = @edit_histories.where(created_at: date.beginning_of_day..date.end_of_day)
    end

    # 買い物リストフィルタ
    if params[:shopping_list_id].present?
      @edit_histories = @edit_histories.where(shopping_list_id: params[:shopping_list_id])
    end

    # ユーザーでフィルタ
    if params[:user_id].present?
      @edit_histories = @edit_histories.where(user_id: params[:user_id])
    end

    if params[:action_type].present?
      @edit_histories = @edit_histories.where(action: params[:action_type])
    end
  end
end
