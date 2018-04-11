FactoryBot.define do
  factory :vote do
    association :tournament
    aasm_state 'new'
  end
end
