class ChangeGroupsToTeams < ActiveRecord::Migration[6.0]
  def change
    rename_table :groups, :teams
  end
end
