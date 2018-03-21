require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'associations' do
    it { should belong_to(:vote) }
  end
end
