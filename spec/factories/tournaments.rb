FactoryBot.define do
  factory :tournament do
    name "MyString"
    number_of_rounds 1
    aasm_state "MyString"
    vote nil
  end
end
