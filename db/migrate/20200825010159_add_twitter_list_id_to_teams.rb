class AddTwitterListIdToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :twitter_list_id, :integer
  end
end
