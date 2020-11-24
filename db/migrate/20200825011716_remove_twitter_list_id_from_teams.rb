class RemoveTwitterListIdFromTeams < ActiveRecord::Migration[6.0]
  def change
    remove_column :teams, :twitter_list_id, :integer
  end
end
