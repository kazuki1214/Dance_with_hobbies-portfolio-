module EndUsers::NotificationsHelper
  #通知機能メソッド
  def unchecked_notifications
    @notifications = current_end_user.passive_notifications.where(checked: false)
  end
end
