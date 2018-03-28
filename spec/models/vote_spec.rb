require 'rails_helper'
require 'aasm/rspec'

RSpec.describe Vote, type: :model do
  it { should belong_to(:tournament) }

  describe 'change of states' do
    it { expect(subject).to transition_from(:new).to(:closed).on_event(:close) }
  end
end
