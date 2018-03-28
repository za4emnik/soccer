class Vote < ApplicationRecord
  include AASM

  belongs_to :tournament

  aasm do
    state :new, initial: true
    state :closed

    event :close do
      transitions from: :new, to: :closed
    end
  end
end
