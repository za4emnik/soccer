require 'ffaker'

FactoryBot.define do
  factory :tournament do
    name { FFaker::Name::first_name }
    number_of_rounds 3
    aasm_state "new"
  end
end
