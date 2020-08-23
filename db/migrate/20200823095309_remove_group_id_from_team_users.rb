class RemoveGroupIdFromTeamUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :team_users, :group_id
  end
end
