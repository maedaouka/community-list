class AddTwitterInfoToTeams < ActiveRecord::Migration[6.0]
  def change
    # add_column :teams, :twitter_list_id, :int,
    add_column :teams, :twitter_list_uri, :string
  end
end
