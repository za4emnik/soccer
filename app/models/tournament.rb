class Tournament < ApplicationRecord
  has_one :vote
  has_and_belongs_to_many :users
end
