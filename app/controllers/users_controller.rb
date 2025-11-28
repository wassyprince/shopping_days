class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @user.update(user_params)
      sign_in @user, bypass: true
      redirect_to calendar_path  # 更新成功
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, notice: "アカウントを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to root_path, alert: "権限がありません" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
