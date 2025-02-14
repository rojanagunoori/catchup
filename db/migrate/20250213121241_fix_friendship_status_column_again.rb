class FixFriendshipStatusColumnAgain < ActiveRecord::Migration[7.0]
  def up
    remove_column :friendships, :status, if_exists: true
    add_column :friendships, :status, :integer, default: 0, null: false
  end

  def down
    remove_column :friendships, :status
    add_column :friendships, :string, default: "pending"
  end
end
