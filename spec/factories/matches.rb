FactoryBot.define do
  factory :match do
    association :first_team, factory: :team
    association :second_team, factory: :team
    association :tournament
    match_type "regular"
    position 1
    aasm_state "MyString"
  end
end
