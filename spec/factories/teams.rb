FactoryBot.define do
  factory :team do
    name "command"
    association :first_member, factory: :user
    association :second_member, factory: :user
  end
end
