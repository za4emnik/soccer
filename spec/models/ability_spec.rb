require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe '#initialize' do
    context 'when admin' do
      subject { Ability.new(FactoryBot.create(:admin)) }

      it { should be_able_to(:manage, :all) }
    end
  end
end
