class CreateThoughts < ActiveRecord::Migration[7.0]
  def change
    create_table :thoughts do |t|
      t.text :content
      t.references :user, foreign_key: true  # Assuming each thought belongs to a user
      t.timestamps
    end
  end
end


