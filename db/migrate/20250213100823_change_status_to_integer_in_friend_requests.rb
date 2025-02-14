class ChangeStatusToIntegerInFriendRequests < ActiveRecord::Migration[6.1]
  def up
    # Add a new integer column
    add_column :friend_requests, :status_int, :integer, default: 0

    # Migrate existing data using SQL (avoiding ActiveRecord model)
    execute <<-SQL
      UPDATE friend_requests SET status_int = 
        CASE 
          WHEN status = 'pending' THEN 0
          WHEN status = 'accepted' THEN 1
          WHEN status = 'rejected' THEN 2
          ELSE 0
        END;
    SQL

    # Remove the old status column
    remove_column :friend_requests, :status

    # Rename the new column to status
    rename_column :friend_requests, :status_int, :status
  end

  def down
    # Re-add the old status column as string
    add_column :friend_requests, :status_str, :string, default: "pending"

    # Convert integer back to string using SQL
    execute <<-SQL
      UPDATE friend_requests SET status_str = 
        CASE 
          WHEN status = 0 THEN 'pending'
          WHEN status = 1 THEN 'accepted'
          WHEN status = 2 THEN 'rejected'
          ELSE 'pending'
        END;
    SQL

    remove_column :friend_requests, :status
    rename_column :friend_requests, :status_str, :status
  end
end
