FactoryBot.define do
  factory :score do
    score 3
    association :team
    association :match
  end
end
