class Idea < ActiveRecord::Base
    validates :idea, presence: true
end