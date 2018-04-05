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

  def edit_teams
    #binding.pry
  end

  def update_teams
    #binding.pry
  end

  private

  def check_players
    if @tournament.users.count % 2 > 0
      flash[:notice] = 'Can\'t generate teams.
                        Number of players should be a multiple of 2.'
      redirect_to admin_tournament_teams_path
    end
  end
end
