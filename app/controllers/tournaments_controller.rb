class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find params[:id]
    @regular_teams = @tournament.teams.with_wins
    @one_eight = @tournament.matches.one_eight.first(8)
    @one_four = @tournament.matches.one_four.first(4)
    @one_two = @tournament.matches.one_two.first(2)
    @final = @tournament.matches.final.first
  end
end
