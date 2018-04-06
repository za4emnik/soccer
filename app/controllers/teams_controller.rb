class TeamsController < ApplicationController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :team, through: :tournament

  def index
    @teams = Team.with_filter(@tournament.teams, params[:player_search])
  end

  def update
    if @team.update_attributes(team_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
