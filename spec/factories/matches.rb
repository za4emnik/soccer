FactoryBot.define do
  first_value = rand(0..10)
  second_value = 10 - first_value
  factory :match do
    association :first_team, factory: :team
    association :second_team, factory: :team
    first_team_result first_value
    second_team_result second_value
    association :tournament
    match_type "regular"
    position 1
    aasm_state "MyString"
  end
end
