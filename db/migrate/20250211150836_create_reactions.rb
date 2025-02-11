class CreateReactions < ActiveRecord::Migration[8.0]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :thought, null: false, foreign_key: true

      t.timestamps
    end
  end
end
