class Team < ApplicationRecord
  belongs_to :first_member, class_name: 'User', foreign_key: 'first_member_id'
  belongs_to :second_member, class_name: 'User', foreign_key: 'second_member_id'
  belongs_to :tournament
  has_many :first_matches, class_name: 'Match', foreign_key: 'first_team_id'
  has_many :second_matches, class_name: 'Match', foreign_key: 'second_team_id'
  has_many :scores

  scope :with_user, ->(user) { where(first_member: user).or(Team.where(second_member: user)) }

  def self.with_wins(relation = Team.all, type = :regular)
    TeamsQuery.new(relation).with_wins(type)
  end

  def self.with_filter(relation, filter)
    TeamsQuery.new(relation).with_filter(filter)
  end
end
