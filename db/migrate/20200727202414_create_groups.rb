class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :uid
      t.string :explanation

      t.timestamps
    end
  end
end
