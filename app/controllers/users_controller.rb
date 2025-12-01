class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @user.valid_password?(params[:user][:current_password])
      if params[:user][:password].blank?
        if changes_only?(user_params.except(:password, :password_confirmation))
          if @user.update(user_params.except(:password, :password_confirmation))
            redirect_to calendar_path, notice: "ユーザー情報を更新しました"
          else
            render :edit, status: :unprocessable_entity
          end
        else
           flash[:notice] = "変更箇所がありません"
          redirect_to edit_user_path(@user)
        end
      else  
        if @user.update(user_params)
          bypass_sign_in(@user)
          redirect_to calendar_path, notice: "ユーザー情報を更新しました"
        else
          render :edit, status: :unprocessable_entity   
        end    
      end
    else
      flash.now[:alert] = "現在のパスワードが正しくありません"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path,  notice: "アカウントを削除しました"
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def changes_only?(params)
  # params に含まれる値が現在のユーザーと違うものがあるかどうかを判定
  params.to_h.any? { |key, value| value.present? && @user[key] != value }
end

end
