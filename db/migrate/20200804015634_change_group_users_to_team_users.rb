class ChangeGroupUsersToTeamUsers < ActiveRecord::Migration[6.0]
  def change
    rename_table :group_users, :team_users
  end
end
