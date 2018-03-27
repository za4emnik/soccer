module Admin::MatchesHelper

  def winner?(match, team)
    match.scores.where(team: team).first.present?
  end
end
