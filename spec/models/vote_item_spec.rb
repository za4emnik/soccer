require 'rails_helper'

RSpec.describe VoteItem, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:vote) }
    it { should belong_to(:vote_user) }
  end
end
