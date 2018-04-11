class UsersQuery
  attr_reader :relation

  def initialize(relation = User.all)
    @relation = relation
  end

  def with_vote_items(user, tournament)
    @relation.joins("LEFT JOIN vote_items ON (vote_items.vote_user_id = users.id AND vote_items.vote_id = #{tournament.vote.id} AND vote_items.user_id = #{user.id})").order('vote_items.value DESC')
  end
end
