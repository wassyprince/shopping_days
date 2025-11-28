class EventsController < ApplicationController
  before_action :authenticate_user! #この記述により、ログインしていないユーザーをログインページの画面に促すことができます。
  
  def calendar
    # 日付ごとの買い物リストの数を取得
    @shopping_counts = ShoppingList.group(:date).count
    
    # カレンダーに表示するために、日付ごとに買い物リストを設定
    @shopping_list = ShoppingList.find_by(date: @date, user: current_user)  # 例: 現在のユーザーの買い物リストを取得
    
    # 予定を取得して @plans に入れる
    @plans = Plan.all   
    
    @date =
      if params[:start_date].present? # カレンダーのタイトル更新
        Date.parse(params[:start_date])
      elsif params[:month].present? 
        params[:month].to_date
      else
        Date.today
      end
  end
end
