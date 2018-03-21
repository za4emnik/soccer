class Tournament < ApplicationRecord
  belongs_to :vote
  has_and_belongs_to_many :users
end
