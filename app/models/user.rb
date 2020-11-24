class User < ApplicationRecord
    has_many :team_user
    # validates :name, presence: true
end
