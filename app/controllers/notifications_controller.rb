class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    @notification = current_user.notification || current_user.build_notification
    if @notification.update(notification_params)
      status = @notification.enabled? ? "ON" : "OFF"
      redirect_to calendar_path(suppress_banner: true), notice: "通知を#{status}にしました"
    else
      redirect_to calendar_path(suppress_banner: true), alert: "通知の更新に失敗しました"
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:enabled)
  end
end
