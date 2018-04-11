class GenerateRatingsService
  def initialize(vote, _args = {})
    @vote = vote
    @tournament = vote.tournament
    @users = @tournament&.users
  end

  def call
    @users&.each do |user|
      create_rating_for(user)
    end
  end

  def rating_value_for(user)
    @tournament.vote.vote_items.where(vote_user: user).sum(:value)
  end

  def rating_for(user)
    User.find(user.id).ratings.where(tournament: @tournament).first_or_initialize
  end

  def create_rating_for(user)
    rating_value = rating_value_for(user)
    rating = rating_for(user)
    rating.rating = rating_value
    rating.save
  end
end
