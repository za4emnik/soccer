class VoteItem < ApplicationRecord
  belongs_to :user
  belongs_to :vote_user, class_name: 'User', foreign_key: 'vote_user_id'
  belongs_to :vote

  scope :with_current_tournament, ->(tournament, user){ where(user_id: user.id, vote_id: tournament.vote.id) }
end
