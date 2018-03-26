require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'associations' do
    it { should belong_to(:first_team) }
    it { should belong_to(:second_team) }
    it { should belong_to(:tournament) }
  end
end
