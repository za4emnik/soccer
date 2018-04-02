class TournamentsController < ApplicationController

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find params[:id]
    @teams = ActiveRecord::Base.connection.execute(
      "SELECT *
       from teams t
        LEFT JOIN (SELECT s.team_id, SUM(s.score) AS score_sum from scores s
        INNER JOIN matches m ON s.match_id = m.id
       WHERE m.tournament_id = #{@tournament.id}
       GROUP BY s.team_id) sc ON sc.team_id = t.id
       ORDER BY sc.score_sum DESC").to_a
       binding.pry
  end
end
