class AddTeamRefToTeamUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :team_users, :team, null: false, foreign_key: true
  end
end
