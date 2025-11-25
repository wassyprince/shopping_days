class ShoppingListsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:date].present?
      # 指定日付のリストだけを表示
      @shopping_lists = ShoppingList.where(date: params[:date])
    else
      @shopping_lists = ShoppingList.all
    end
  end

  def show
    @shopping_list = ShoppingList.find(params[:id])
  end

  def new
    @shopping_list = ShoppingList.new(date: params[:date])
  end
 

  def create
    @shopping_list = ShoppingList.new(shopping_list_params)
    @shopping_list.user = current_user
    if @shopping_list.save
      redirect_to @shopping_list, notice: "リストを作成しました"
    else
      render :new
    end
  end

  def destroy
    @shopping_list = ShoppingList.find(params[:id])
    @shopping_list.destroy
    redirect_to shopping_lists_path, notice: "ショッピングリストを削除しました"
  end

  def show_by_date
    day = Date.parse(params[:date])
    @shopping_lists = ShoppingList.where(date: day.beginning_of_day..day.end_of_day)

    render :index
  end

  private

  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:id])
  end

  def shopping_list_params
    params.require(:shopping_list).permit(:date, :title, :memo)
  end
end