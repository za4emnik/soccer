class GenerateMatchesService
  def initialize(tournament)
    @tournament = tournament
    @teams = tournament.teams.to_a
  end

  def generate
    shuffle_teams()
    create_regular_matches()
  end

  def create_regular_matches
    get_number_of_regular_matches.times do
      create_match(@teams.shift(), @teams.shift())
    end
  end

  def create_match(first_team, second_team)
    @tournament.number_of_rounds.times do
      match = Match.new(match_type: 'regular', tournament: @tournament)
      match.first_team = first_team
      match.second_team = second_team
      match.save!
    end
  end

  def shuffle_teams
    @teams = @teams.shuffle()
  end

  def get_number_of_regular_matches
    (@tournament.users.count / 2).to_i
  end
end
