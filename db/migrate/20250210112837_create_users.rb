class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, unique: true
      t.string :encrypted_password

      #t.string :password_digest  # For authentication
      t.timestamps
    end
  end
end


