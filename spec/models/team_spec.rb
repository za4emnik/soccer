require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'associations' do
    it { should belong_to(:first_member) }
    it { should belong_to(:second_member) }
    it { should belong_to(:tournament) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:first_member) }
    it { should validate_presence_of(:second_member) }
    it { should validate_presence_of(:tournament) }
    it { should validate_length_of(:name).is_at_most(30).is_at_least(3) }
  end
end
