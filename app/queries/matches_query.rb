class MatchesQuery
  attr_reader :relation

  def initialize(relation = Match.all)
    @relation = relation
  end

  def with_filter(filter)
    prepare_filter(filter) if filter&.[](:name) && filter&.[](:type)
    @relation&.uniq
  end

  def prepare_filter(filter)
    @relation = if filter[:type] == 'team'
                  filter_by_team(filter)
                else
                  filter_by_player(filter)
                end
  end

  def filter_by_team(filter)
    with_teams.where("teams.name LIKE '%#{filter[:name]}%'")
  end

  def filter_by_player(filter)
    with_users.where("users.email LIKE '%#{filter[:name]}%'")
  end

  def with_teams
    @relation.joins('LEFT JOIN teams ON matches.first_team_id = teams.id OR matches.second_team_id = teams.id')
  end

  def with_users
    with_teams.joins('RIGHT JOIN users ON teams.first_member_id = users.id OR teams.second_member_id = users.id')
  end
end
