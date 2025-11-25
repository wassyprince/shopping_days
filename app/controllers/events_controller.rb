class EventsController < ApplicationController
  before_action :authenticate_user! #この記述により、ログインしていないユーザーをログインページの画面に促すことができます。
  
  def calendar
    # 日付ごとの買い物リストの数を取得
    @shopping_counts = ShoppingList.group(:date).count
    @date = params[:month]&.to_date || Date.today

    # カレンダーに表示するために、日付ごとに買い物リストを設定
    @shopping_list = ShoppingList.find_by(date: @date, user: current_user)  # 例: 現在のユーザーの買い物リストを取得
    
    # カレンダーに表示するためのイベント（買い物リスト）
    @events = ShoppingList.where(date: @date, user: current_user) # 例: 現在のユーザーの特定の日付に関連する買い物リストを取得
  end
end
