class AddTwitterinfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :screen_name, :string
    add_column :users, :image_url, :string
  end
end
