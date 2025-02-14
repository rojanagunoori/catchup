class AddDefaultToFriendStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default :friend_requests, :friend_status, 0
    change_column_null :friend_requests, :friend_status, false
  end
end
