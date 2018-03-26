class GenerateTeamsService
  def initialize(tournament)
    @tournament = tournament
    @users = tournament.users
  end

  def generate
    remove_teams()
    shuffle_players()
    create_teams()
  end

  def remove_teams
    @tournament.teams.delete_all
  end

  def shuffle_players
    users = @tournament.users.sort_by{ |user| user.ratings.last.rating }.in_groups_of(2)
    @users = users.map(&:shuffle).flatten
  end

  def generate_team_name(first_player, last_palyer)
    "#{first_player.email}_#{last_palyer.email}"
  end

  def create_teams
    (@users.size / 2).times do
      name = generate_team_name(@users.first, @users.last)
      create_team(name, @users.shift, @users.pop)
    end
  end

  def create_team(name, first_palyer, second_player)
    team = Team.new(name: name, tournament: @tournament)
    team.first_member = first_palyer
    team.second_member = second_player
    team.save!
  end
end
