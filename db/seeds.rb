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

#create tournament
tournament = Tournament.create!(name: 'New tournament', number_of_rounds: 3)

#create ratings for 16 users and assign 16 users to tournament
users = User.first(16)
users.each do |user|
  user.ratings << Rating.create!(tournament: tournament, user: user, rating: rand(0..5))
  tournament.users << user
end

#create 8 teams
8.times do
  name = "#{users.first.email}_#{users.second.email}"
  tournament.teams << Team.create!(first_member: users.shift(), second_member: users.shift(), name: name, tournament: tournament)
end

#create matches for 8 teams (4 matches * rounds) with scores
teams = tournament.teams.to_a
4.times do
  first_team = teams.shift()
  second_team = teams.shift()
  teams_array = [first_team, second_team]
  tournament.number_of_rounds.times do
    match = Match.create!(first_team: first_team, second_team: second_team, tournament: tournament, match_type: 'regular')
    Score.create!(match: match, team: teams_array.sample, score: 3)
  end
end
