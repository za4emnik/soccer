FactoryBot.define do
  factory :rating do
    association :tournament
    association :user
    rating { rand(0..5) }
  end
end
