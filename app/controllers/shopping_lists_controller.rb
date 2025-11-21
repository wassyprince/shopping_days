class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 日付ごとの件数をハッシュ化
    @shopping_counts = ShoppingList.group(:date).count
    @date = params[:month]&.to_date || Date.today
  end

  def show_by_date
    day = Date.parse(params[:date])
    @shopping_lists = ShoppingList.where(date: day.beginning_of_day..day.end_of_day)

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def new
    @shopping_list = current_user.shopping_lists.build(date: params[:date])
  end

  def create
    @shopping_list = current_user.shopping_lists.build(shopping_list_params)
    if @shopping_list.save
      redirect_to calendar_events_path, notice: "買い物リストを作成しました"
    else
      render "events/calendar", status: :unprocessable_entity
    end
  end

  private

  def shopping_list_params
    params.require(:shopping_list).permit(:date)
  end
end