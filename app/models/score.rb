class Score < ApplicationRecord
  belongs_to :team
  belongs_to :match

  attribute :score, :integer, default: 3
end
