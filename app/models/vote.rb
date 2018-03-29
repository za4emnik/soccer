class Vote < ApplicationRecord
  include AASM

  has_many :vote_items
  belongs_to :tournament

  aasm do
    state :new, initial: true
    state :closed

    event :close do
      transitions from: :new, to: :closed, after: GenerateRatingsService
    end
  end
end
