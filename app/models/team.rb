class Team < ApplicationRecord
  belongs_to :first_member, class_name: 'User', foreign_key: 'first_member_id'
  belongs_to :second_member, class_name: 'User', foreign_key: 'second_member_id'
  belongs_to :tournament
  has_many :first_matches, class_name: 'Match', foreign_key: 'first_team_id'
  has_many :second_matches, class_name: 'Match', foreign_key: 'second_team_id'
  has_many :scores

  scope :with_user, ->(user) { where(first_member: user).or(Team.where(second_member: user)) }
  scope :with_matches, -> { joins("LEFT JOIN matches ON matches.first_team_id = teams.id OR matches.second_team_id = teams.id") }

  def self.with_wins(type = :regular)
    sql_case = "SUM(CASE WHEN (matches.first_team_id = teams.id AND matches.first_team_result > matches.second_team_result) OR
                  (matches.second_team_id = teams.id AND matches.first_team_result < matches.second_team_result) THEN 1 ELSE 0 END)"
    count_matches = "COUNT(matches.id)"
    scoring_goals = "SUM(CASE WHEN matches.first_team_id = teams.id THEN matches.first_team_result
                              WHEN matches.second_team_id = teams.id THEN matches.second_team_result END)"
    conceded_goals = "SUM(CASE WHEN matches.first_team_id = teams.id THEN matches.second_team_result
                              WHEN matches.second_team_id = teams.id THEN matches.first_team_result END)"
    self.with_matches.where("matches.match_type = #{Match.match_types[:regular]}")
        .select("teams.*, #{count_matches} AS matches_count, #{sql_case} AS wins,
               (#{count_matches} - #{sql_case}) AS defeats, #{scoring_goals} AS scoring_goals,
                #{conceded_goals} AS conceded_goals").group("teams.id").order("wins DESC")
  end
end
