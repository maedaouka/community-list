class Team < ApplicationRecord
    def to_param
        uid
    end
end
