class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find params[:id]
    @regular_teams = @tournament.teams.with_wins
    @play_off = @tournament.teams.with_wins(:play_off).first(16)
  end
end
