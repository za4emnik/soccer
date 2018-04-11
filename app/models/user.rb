class User < ApplicationRecord
  before_create :generate_rating

  has_many :ratings
  has_many :vote_items
  has_and_belongs_to_many :tournaments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  scope :with_filter, -> (search) { where("users.email LIKE '%#{search}%'") }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

  def self.with_vote_items(user, tournament)
    UsersQuery.new(self).with_vote_items(user, tournament)
  end

  private

  def generate_rating
    self.initial_rating = (60 * (Rating.average(:rating) || 2)) / 100
  end
end
