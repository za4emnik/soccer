class HomeController < ApplicationController

  def index
    @tournaments = current_user.tournaments.with_filter(params[:search])
    @teams = Team.with_user(current_user)
  end
end
