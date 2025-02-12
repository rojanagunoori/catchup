class AddProfilePictureUrlToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :profile_picture_url, :string
  end
end
