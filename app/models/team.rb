class Team < ApplicationRecord
    has_many :team_user
    def to_param
        uid
    end
end
