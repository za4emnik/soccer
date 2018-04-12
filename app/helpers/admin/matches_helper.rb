module Admin::MatchesHelper
  def winner?(match, team)
    team_number = get_team_number(match, team)
    win?(match, team_number)
  end

  def winner(match)
    if win?(match, 'first_team')
      match&.first_team&.name
    elsif win?(match, 'second_team')
      match&.second_team&.name
    elsif win?(match, 'second_team').nil?
      'not played yet'
    else
      'dead heat'
    end
  end

  private

  def get_team_number(match, team)
    match.first_team == team ? 'first_team' : 'second_team'
  end

  def win?(match, team_number)
    next_team_number = team_number == 'first_team' ? 'second_team' : 'first_team'
    match.public_send("#{team_number}_result")&.> match.public_send("#{next_team_number}_result")
  end
end
