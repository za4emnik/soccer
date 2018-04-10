class Admin::TeamsController < Admin::AdminBaseController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :user, through: :tournament

  def index
    @teams = Team.with_filter(@tournament.teams, params[:player_search])
  end

  def new
  end

  def destroy
    @tournament.users.delete(User.find(params[:id]))
  end

  def generate_teams
    check_players
    service = GenerateTeamsService.new(@tournament)
    service.generate()
    redirect_to admin_tournament_teams_path
  end

  def update_teams
    if valid_data?(params[:teams])
      update_teams_players(params[:teams])
      redirect_to admin_tournament_teams_path
    else
      flash[:notice] = 'Can\'t update teams. Teams should be contain 2 players'
      redirect_to edit_teams_admin_tournament_teams_path
    end
  end

  private

  def update_teams_players(teams)
    teams.each do |key, value|
      @tournament.teams.find(key).update_attributes(first_member_id: value[0], second_member_id: value[1])
    end
  end

  def teams_params(team)
    team.permit(:first_member_id, :second_member_id)
  end

  def valid_data?(teams)
    team_exist?(teams) && players_ready?(teams)
  end

  def team_exist?(teams)
    (teams.keys.map(&:to_i) - @tournament.teams.ids).empty?
  end

  def players_ready?(teams)
    users = (@tournament.users.ids - teams.values.flatten.map(&:to_i)).empty?
    count_players = teams.values.size*2 == teams.values.flatten.uniq.size
    users && count_players
  end

  def check_players
    if @tournament.users.count % 2 > 0
      flash[:notice] = 'Can\'t generate teams.
                        Number of players should be a multiple of 2.'
      redirect_to admin_tournament_teams_path
    end
  end
end
