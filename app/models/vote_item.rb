class VoteItem < ApplicationRecord
  belongs_to :user
  belongs_to :vote_user, class_name: 'User', foreign_key: 'vote_user_id'
  belongs_to :vote
end
