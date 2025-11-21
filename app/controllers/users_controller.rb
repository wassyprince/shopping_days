class UsersController < ApplicationController
  #before_action :authenticate_user! #この記述により、ログインしていないユーザーをログインページの画面に促すことができます。

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path  # 更新成功
    else
      render :edit, status: :unprocessable_entity  # 更新失敗時は再度編集フォームを表示
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
