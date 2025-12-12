class ItemsController < ApplicationController
  before_action :set_shopping_list, only: [:edit, :create, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :destroy]

  # アイテム編集フォーム表示
  def edit
  end
  
  # アイテムの作成
  def create
    @item = @shopping_list.items.build(item_params)

    if @item.save
      EditHistory.create!(
      user: current_user,
      shopping_list: @shopping_list,
      item: @item,
      action: :created,
      after_name: @item.name,
      after_quantity: @item.quantity,
      after_category: @item.category
    )
      redirect_to @shopping_list, notice: "品物を追加しました"
    else
      Rails.logger.debug "ERRORS: #{@item.errors.full_messages}"
      flash.now[:alert] = "品物の追加に失敗しました"
      @items = @shopping_list.items.order(created_at: :desc)
      render "shopping_lists/show", status: :unprocessable_entity
    end
  end

  # アイテムの更新
  def update
    # 更新前の値を控える（ここがないと NameError）
    before_name = @item.name
    before_quantity = @item.quantity
    before_category = @item.category
    before_purchased = @item.purchased
    before_memo = @item.memo
    if @item.update(item_params)
      EditHistory.create!(
      user: current_user,
      shopping_list: @shopping_list,
      item: @item,
      action: :updated,
      before_name: before_name,
      after_name: @item.name,
      before_quantity: before_quantity,
      after_quantity: @item.quantity,
      before_category: before_category,
      after_category: @item.category,
      before_purchased: before_purchased,
      after_purchased: @item.purchased,
      before_memo: before_memo,
      after_memo: @item.memo
    )
      redirect_to @shopping_list, notice: "品物を更新しました"
    else
      flash.now[:alert] = "品物の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  # アイテムの削除
  def destroy

    EditHistory.create!(
    user: current_user,
    shopping_list: @shopping_list,
    item: @item,
    action: :deleted,
    before_name: @item.name,
    before_quantity: @item.quantity,
    before_category: @item.category,
    after_category: @item.category
  )

    @item.destroy
    redirect_to @shopping_list, notice: "品物を削除しました"
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
