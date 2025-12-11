class ShoppingListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shopping_list, only: [:show, :edit, :update, :destroy]

  def index
    if params[:date].present?
      # 指定日付のリストだけを表示
      @shopping_lists = ShoppingList.where(date: params[:date]).order(date: :desc)
    else
      @shopping_lists = ShoppingList.order(date: :desc, created_at: :desc)
    end
  end

  def show
    @items = @shopping_list.items.order(created_at: :desc)  
    @item = @shopping_list.items.build
  end

  def new
    @shopping_list = ShoppingList.new(date: params[:date])
  end 

  def create
    @shopping_list = current_user.shopping_lists.new(shopping_list_params)
    if @shopping_list.save
      redirect_to @shopping_list, notice: "買い物リストを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shopping_list.update(shopping_list_params)
      record_list_history(@shopping_list)
      redirect_to @shopping_list, notice: "買い物リストを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shopping_list.destroy
    redirect_to shopping_lists_path, notice: "買い物リストを削除しました"
  end

  def show_by_date
    day = Date.parse(params[:date])
    @shopping_lists = ShoppingList.where(date: day.beginning_of_day..day.end_of_day)
    render :index
  end

  def today
    @shopping_lists = current_user.shopping_lists.where(date: Date.today).order(created_at: :desc)
    if @shopping_lists.present?
      render :today
    else
      redirect_to shopping_lists_path, notice: "今日のリストはありません"
    end
  end

  private

  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:id])
  end

  def shopping_list_params
    params.require(:shopping_list).permit(:date, :title)
  end

  def record_list_history(list)
    if list.saved_change_to_title?
      EditHistory.create!(
        user: current_user,
        shopping_list: list,
        action: :list_name_updated,
        before_list_title: list.title_before_last_save,
        after_list_title: list.title
      )
    end

    if list.saved_change_to_date?
      EditHistory.create!(
        user: current_user,
        shopping_list: list,
        action: :list_date_updated,
        before_date: list.date_before_last_save,
        after_date: list.date
      )
    end
  end
end