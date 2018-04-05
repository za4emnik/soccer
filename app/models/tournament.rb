class Tournament < ApplicationRecord
  include AASM

  has_one :vote, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :matches
  has_many :scores, through: :matches
  has_and_belongs_to_many :users, dependent: :destroy

  default_scope { includes(:users) }

  aasm do
    state :new, initial: true
    state :in_process
    state :completed

    event :processed do
      transitions from: :new, to: :in_process
    end

    event :complete do
      transitions from: :in_process, to: :completed, after: :create_vote
    end
  end

  def self.with_filter(relation, filter)
    relation = relation.where("name LIKE ?", "%#{filter[:search]}%") if filter&.[](:search)
    relation = relation.where(aasm_state: filter[:type]) if filter&.[](:type).present?
    relation
  end

  def create_vote
    Vote.create!(tournament: self)
  end
end
