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

tournament = Tournament.create!(name: 'New tournament')
users = User.first(14)
users.each { |user| user.ratings << Rating.create!(tournament: tournament, user: user, rating: rand(0..5)) }
users.count.times { tournament.users << users.shift }
