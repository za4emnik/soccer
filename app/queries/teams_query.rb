class TeamsQuery
  attr_reader :relation

  def initialize(relation = Team.all)
   @relation = relation
  end

  def with_wins(type = :regular)
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

  def with_matches
    relation.joins("LEFT JOIN matches ON matches.first_team_id = teams.id OR matches.second_team_id = teams.id")
  end

  def with_filter(filter)
    if filter&.[](:name)
      @relation = with_users
      first_member = "users.email LIKE '%#{filter[:name]}%'"
      @relation = @relation.where(first_member)
    end
    @relation&.uniq
  end

  def with_users
    relation.joins("RIGHT JOIN users ON teams.first_member_id = users.id OR teams.second_member_id = users.id")
  end
end
