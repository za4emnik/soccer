class Admin::TeamsController < Admin::AdminBaseController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :user, through: :tournament

  def index
    @teams = Team.with_filter(@tournament.teams, params[:player_search])
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find params[:id]
  end

  def update
    @team = Team.find params[:id]
    @team.update_attributes(team_edit_params)
    @team.save ? redirect_to(admin_tournament_teams_path) : render(:edit)
  end

  def create
    @team = @tournament.teams.new(teams_params)
    @team.save ? redirect_to(admin_tournament_teams_path) : render(:new)
  end

  def destroy
    @tournament.teams.delete(Team.find(params[:id]))
    redirect_to admin_tournament_teams_path
  end

  def generate_teams
    if (@tournament.users.count % 2).positive?
      flash[:notice] = 'Can\'t generate teams.
                        Number of players should be a multiple of 2.'
    else
      service = GenerateTeamsService.new(@tournament)
      service.generate
    end
    redirect_to admin_tournament_teams_path
  end

  def update_teams
    if valid_data?(params[:teams])
      update_teams_players(params[:teams])
      redirect_to admin_tournament_teams_path
    else
      flash[:notice] = 'Can\'t update teams. Teams should be contain 2 players or
                       some players are not present in tournament. Check players.'
      redirect_to edit_teams_admin_tournament_teams_path
    end
  end

  private

  def update_teams_players(teams)
    teams.each do |key, value|
      @tournament.teams.find(key).update_attributes(first_member_id: value[0], second_member_id: value[1])
    end
  end

  def teams_params
    params.require(:team).permit(:name, :first_member_id, :second_member_id)
  end

  def team_edit_params
    params.require(:team).permit(:name)
  end

  def valid_data?(teams)
    team_exist?(teams) && players_ready?(teams)
  end

  def team_exist?(teams)
    (teams.keys.map(&:to_i) - @tournament.teams.ids).empty?
  end

  def players_ready?(teams)
    users = (@tournament.users.ids - teams.values.flatten.map(&:to_i)).empty?
    count_players = teams.values.size * 2 == teams.values.flatten.uniq.size
    users && count_players
  end

  def check_players
    if (@tournament.users.count % 2).positive?
      flash[:notice] = 'Can\'t generate teams.
                        Number of players should be a multiple of 2.'
      redirect_to admin_tournament_teams_path
    end
  end

  def users_even?
    (@tournament.users.count % 2).positive?
  end
end
