class RenameReactionsToLikes < ActiveRecord::Migration[6.0]
  def change
    rename_table :reactions, :likes
  end
end
