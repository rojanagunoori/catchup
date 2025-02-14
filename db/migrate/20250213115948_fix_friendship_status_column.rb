class FixFriendshipStatusColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :friendships, :status, if_exists: true
    add_column :friendships, :status, :integer, default: 0, null: false
  end
end
