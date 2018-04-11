User.create!(email: 'admin@example.com', password: '12345678', password_confirmation: '12345678', is_admin: true)
User.create!(email: 'admin@example1.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example2.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example3.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example4.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example5.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example6.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example7.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example8.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example9.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example10.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example11.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example12.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example13.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example14.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example15.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example16.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example17.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example18.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example19.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example20.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example21.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example22.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example23.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example24.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example25.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example26.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example27.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example28.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example29.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example30.com', password: '12345678', password_confirmation: '12345678')
User.create!(email: 'admin@example31.com', password: '12345678', password_confirmation: '12345678')

3.times do
  # create tournament
  tournament = Tournament.create!(name: 'New tournament', number_of_rounds: 3, aasm_state: 'in_process')

  # create ratings for 32 users and assign 32 users to tournament
  users = User.first(32)
  users.each do |user|
    user.ratings << Rating.create!(tournament: tournament, user: user, rating: rand(0..5))
    tournament.users << user
  end

  # create 16 teams
  16.times do
    name = "#{users.first.email}_#{users.second.email}".truncate(29)
    tournament.teams << Team.create!(first_member: users.shift, second_member: users.shift, name: name, tournament: tournament)
  end

  # create matches for 16 teams (8 matches * rounds) with scores
  teams = tournament.teams.to_a
  8.times do
    first_team = teams.shift
    second_team = teams.shift
    teams_array = [first_team, second_team]
    tournament.number_of_rounds.times do
      first_team_result = rand(0..10)
      second_team_result = 10 - first_team_result
      Match.create!(first_team: first_team, second_team: second_team, tournament: tournament, first_team_result: first_team_result, second_team_result: second_team_result, match_type: Match.match_types[:regular])
      # Score.create!(match: match, team: teams_array.sample, score: 3)
    end
  end

  # create 1/8 matches
  one_eighth = tournament.teams.with_wins.first(16).to_a
  8.times do
    first_team_result1 = rand(0..10)
    second_team_result1 = 10 - first_team_result1
    Match.create!(first_team: one_eighth.shift, second_team: one_eighth.shift, tournament: tournament, first_team_result: first_team_result1, second_team_result: second_team_result1, match_type: Match.match_types[:one_eighth])
  end

  # create 1/4 matches
  one_four = tournament.teams.with_wins.first(8).to_a
  4.times do
    first_team_result1 = rand(0..10)
    second_team_result1 = 10 - first_team_result1
    Match.create!(first_team: one_four.shift, second_team: one_four.shift, tournament: tournament, first_team_result: first_team_result1, second_team_result: second_team_result1, match_type: Match.match_types[:one_four])
  end

  # create 1/2 matches
  one_two = tournament.teams.with_wins.first(4).to_a
  2.times do
    first_team_result1 = rand(0..10)
    second_team_result1 = 10 - first_team_result1
    Match.create!(first_team: one_two.shift, second_team: one_two.shift, tournament: tournament, first_team_result: first_team_result1, second_team_result: second_team_result1, match_type: Match.match_types[:one_two])
  end

  # create final
  final = tournament.teams.with_wins.first(2).to_a
  first_team_result1 = rand(0..10)
  second_team_result1 = 10 - first_team_result1
  Match.create!(first_team: final.shift, second_team: final.shift, tournament: tournament, first_team_result: first_team_result1, second_team_result: second_team_result1, match_type: Match.match_types[:final])

  # create match for 3d place
  final = tournament.teams.with_wins.first(2).to_a
  first_team_result1 = rand(0..10)
  second_team_result1 = 10 - first_team_result1
  Match.create!(first_team: final.shift, second_team: final.shift, tournament: tournament, first_team_result: first_team_result1, second_team_result: second_team_result1, match_type: Match.match_types[:final])
end
