class ChangeThoughtIdNullableOnLikes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :likes, :thought_id, true
  end
end
