class Match < ApplicationRecord
  enum match_type: [ :regular, :one_eight, :one_four, :one_two, :third_place, :final ]
  acts_as_list scope: :tournament

  belongs_to :first_team, class_name: 'Team', foreign_key: 'first_team_id'
  belongs_to :second_team, class_name: 'Team', foreign_key: 'second_team_id'
  belongs_to :tournament
  has_many :scores

  # scope :with_teams,         -> { left_joins(:first_team, :second_team) }
  scope :one_eight_matches,  -> { one_eight.first(16) }
  scope :one_four_matches,   -> { one_four.first(8) }
  scope :one_two_matches,    -> { one_two.first(4) }
  scope :final_match,        -> { final.first }

  default_scope { includes(:first_team, :second_team).order(:position) }

  def self.points_for_victory
    3
  end

  def self.with_filter(relation, filter)
    MatchesQuery.new(relation).with_filter(filter)
  end
end
