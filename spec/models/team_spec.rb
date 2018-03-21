require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'associations' do
    it { should belong_to(:first_member) }
    it { should belong_to(:second_member) }
  end
end
