class AddFriendStatusToFriendRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :friend_requests, :friend_status, :integer, default: 0, null: false
  end
end
