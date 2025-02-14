class ChangeStatusToIntegerInFriendships < ActiveRecord::Migration[7.0]

  def change
    change_column :friendships, :status, :integer, default: 0, null: false
  end
  
  def up
    change_column :friendships, :status, :integer, using: "status::integer", default: 0
  end

  def down
    change_column :friendships, :status, :string, default: "pending"
  end
end
