class Match < ApplicationRecord
  enum match_type: [ :regular, :one_eighth, :one_four, :one_two, :third_place ]

  belongs_to :first_team, class_name: 'Team', foreign_key: 'first_team_id'
  belongs_to :second_team, class_name: 'Team', foreign_key: 'second_team_id'
  belongs_to :tournament
  has_many :scores

  default_scope { includes(:first_team, :second_team).order(id: :desc) }
end
