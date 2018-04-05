class HomeController < ApplicationController

  def index
    @tournaments = Tournament.with_filter(current_user.tournaments, params[:tournament_search])
    @teams = Team.with_filter(Team.with_user(current_user), params[:player_search])
  end
end
