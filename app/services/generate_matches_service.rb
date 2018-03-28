class GenerateMatchesService
  def initialize(tournament)
    @tournament = tournament
    @teams = tournament.teams.to_a
  end

  def generate
    @tournament.processed!
    remove_matches()
    shuffle_teams()
    create_regular_matches()
  end

  def remove_matches
    @tournament.matches.delete_all
  end

  def create_regular_matches
    get_number_of_regular_matches.times do
      first_team = @teams.shift()
      second_team = @teams.shift()
      @tournament.number_of_rounds.times { create_match(first_team, second_team) }
    end
  end

  def create_match(first_team, second_team)
    match = Match.new(match_type: 'regular', tournament: @tournament)
    match.first_team = first_team
    match.second_team = second_team
    match.save!
  end

  def shuffle_teams
    @teams = @teams.shuffle()
  end

  def get_number_of_regular_matches
    (@tournament.teams.count / 2).to_i
  end
end
