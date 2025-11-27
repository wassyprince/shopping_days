class HomeController < ApplicationController
  def index
     if user_signed_in?
      redirect_to calendar_path
    else
      # 未ログインならそのまま home#index のビューを表示
    end
  end
end
