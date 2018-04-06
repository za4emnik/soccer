class Tournament < ApplicationRecord
  include AASM

  validates :name, :number_of_rounds, presence: true
  validates :name, length: { minimum: 3, maximum: 30 }
  validates :number_of_rounds, numericality: { greater_than: 0, less_than: 5 }

  has_one :vote, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_and_belongs_to_many :users, dependent: :destroy

  default_scope { includes(:users, :vote) }

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
    relation = relation.order(:id)
    relation
  end

  private

  def create_vote
    Vote.create!(tournament: self)
  end
end
