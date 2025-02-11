class ChangeCommentIdNullableOnLikes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :likes, :comment_id, true
  end
end
