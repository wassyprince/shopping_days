class ApplicationController < ActionController::Base
  #before_action :authenticate_user! #この記述により、ログインしていないユーザーをログインページの画面に促すことができます。
  before_action :configure_permitted_parameters, if: :devise_controller? # :devise_controller?というdeviseのヘルパーメソッド名を指定して、#もしdeviseに関するコントローラーの処理であれば、そのときだけconfigure_permitted_parametersメソッドを実行するように設定しています。
  
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path   # ← ログアウト後にサインインページへ
  end
  
  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
