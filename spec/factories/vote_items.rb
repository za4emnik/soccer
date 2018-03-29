FactoryBot.define do
  factory :vote_item do
    association :user
    association :vote_user, factory: :user
    association :vote
    value 5
  end
end
