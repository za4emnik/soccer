class Match < ApplicationRecord
  enum match_type: [ :regular, :one_eighth, :one_four, :one_two, :third_place ]
  acts_as_list scope: :tournament

  belongs_to :first_team, class_name: 'Team', foreign_key: 'first_team_id'
  belongs_to :second_team, class_name: 'Team', foreign_key: 'second_team_id'
  belongs_to :tournament
  has_many :scores
  # attribute :points_for_victory, :integer, default: 3

  #scope :with_wins, -> { select("SUM(CASE WHEN matches.first_team_id = teams.id AND matches.first_team_result > matches.second_team_result THEN 1 WHEN matches.second_team_id = teams.id AND matches.first_team_result < matches.second_team_result THEN 0 END) AS wins").from('matches, teams') }

  default_scope { includes(:first_team, :second_team).order(:position) }

  def self.points_for_victory
    3
  end
end

# "SELECT teams.id, matches.id, matches.first_team_id, matches.second_team_id,
  # SUM(CASE WHEN matches.first_team_id = teams.id AND matches.first_team_result > matches.second_team_result
    # THEN 1 WHEN matches.second_team_id = teams.id AND matches.first_team_result < matches.second_team_result
    # THEN 0 END) AS wins
  # FROM matches, teams WHERE \"matches\".\"tournament_id\" = 1
  # GROUP BY teams.id, matches.id ORDER BY \"matches\".\"position\" ASC"
#
  # @tournament.matches.select("teams.id, matches.id, matches.first_team_id, matches.second_team_id, SUM(CASE WHEN matches.first_team_id = teams.id AND matches.first_team_result > matches.second_team_result THEN 1 WHEN matches.second_team_id = teams.id AND matches.first_team_result < matches.second_team_result THEN 0 END) AS wins").from('matches, teams').group('matches.id', 'teams.id').first
#
  # @tournament.matches.unscoped.select("AVG(matches.first_team_id), AVG(matches.second_team_id), MAX(matches.id) AS c, SUM(matches.first_team_result) AS wins").group("matches.first_team_id").reload
