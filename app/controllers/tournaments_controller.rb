class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.with_filter(Tournament.all, params[:tournament_search])
  end

  def show
    @tournament = Tournament.find params[:id]
    @regular_teams = Team.with_wins(@tournament.teams, :regular)
    @one_eight = @tournament.matches.one_eight.first(8)
    @one_four = @tournament.matches.one_four.first(4)
    @one_two = @tournament.matches.one_two.first(2)
    @final = @tournament.matches.final.first
  end
end
