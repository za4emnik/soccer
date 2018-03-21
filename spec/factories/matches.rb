FactoryBot.define do
  factory :match do
    first_team nil
    second_team nil
    type ""
    position 1
    aasm_state "MyString"
  end
end
