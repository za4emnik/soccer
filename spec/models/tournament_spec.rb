require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'associations' do
    it { should belong_to(:vote) }
    it { should have_and_belong_to_many(:users) }
  end
end
