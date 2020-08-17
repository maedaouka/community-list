class AddAuthorityToTeamUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :team_users, :is_admin, :boolean
    add_column :team_users, :is_inviting, :string
  end
end
