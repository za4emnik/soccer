class Tournament < ApplicationRecord
  has_one :vote, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :matches
  has_many :scores, through: :teams
  has_and_belongs_to_many :users, dependent: :destroy
  default_scope { includes(:users) }
end
