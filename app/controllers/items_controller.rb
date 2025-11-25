class ItemsController < ApplicationController
  before_action :set_shopping_list
  before_action :set_item, only: [:update, :destroy]

  # アイテムの作成
  def create
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
    @item = @shopping_list.items.build(item_params)

    if @item.save
      redirect_to @shopping_list, notice: "アイテムを追加しました"
    else
      Rails.logger.debug "ERRORS: #{@item.errors.full_messages}"
      flash.now[:alert] = "アイテムの追加に失敗しました"
      render "shopping_lists/show"
    end
  end

  # アイテムの更新
  def update
    if @item.update(item_params)
      redirect_to @shopping_list, notice: "アイテムを更新しました"
    else
      redirect_to @shopping_list, alert: "アイテムの更新に失敗しました"
    end
  end

  # アイテムの削除
  def destroy
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
    @item = @shopping_list.items.find(params[:id])
    @item.destroy
    redirect_to @shopping_list, notice: "アイテムを削除しました"
  end

  private

  # ショッピングリストをセット
  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
  end

  # アイテムをセット
  def set_item
    @item = @shopping_list.items.find(params[:id])
  end

  # アイテムのパラメータを設定
  def item_params
    params.require(:item).permit(:name, :quantity, :category, :memo, :purchased)
  end
end
