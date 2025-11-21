class EventsController < ApplicationController
  before_action :authenticate_user! #この記述により、ログインしていないユーザーをログインページの画面に促すことができます。
  
  def calendar
    @date = params[:month]&.to_date || Date.today
    
    # simple_calendar に渡すイベント（ここでは ShoppingList を使う）
    @events = ShoppingList.all
    
    # 日付ごとのイベントをハッシュにまとめる
     @shopping_counts = ShoppingList.group(:date).count
  end
end
