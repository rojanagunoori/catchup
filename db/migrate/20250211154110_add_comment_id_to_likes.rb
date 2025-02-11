class AddCommentIdToLikes < ActiveRecord::Migration[8.0]
  def change
    add_reference :likes, :comment, null: false, foreign_key: true
  end
end
