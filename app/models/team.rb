class Team < ApplicationRecord
  belongs_to :first_member, class_name: 'User', foreign_key: 'first_member_id'
  belongs_to :second_member, class_name: 'User', foreign_key: 'second_member_id'
  belongs_to :tournament
  has_many :first_matches, class_name: 'Match', foreign_key: 'first_team_id'
  has_many :second_matches, class_name: 'Match', foreign_key: 'second_team_id'
  has_many :scores

  scope :with_matches, -> { includes(:first_matches, :second_matches).where(first_matches) }
  scope :with_wins, -> { select("SUM(CASE WHEN matches.first_team_id = teams.id AND matches.first_team_result > matches.second_team_result THEN 1 WHEN matches.second_team_id = teams.id AND matches.first_team_result < matches.second_team_result THEN 0 END) AS wins").from('matches, teams') }

  # scope :with_wins, -> { joins("LEFT JOIN matches ON (matches.first_team_id = teams.id) AND (matches.second_team_id = teams.id)") }
end
