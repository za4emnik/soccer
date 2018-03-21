require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  describe '#initialize' do
    context 'when admin' do
      subject { Ability.new(FactoryBot.create(:admin)) }

      it { should be_able_to(:manage, :all) }
    end

    #context 'when user' do
    #  let(:user) { FactoryBot.create(:user) }
    #  subject { Ability.new(user) }

    #  it { should be_able_to(:manage, User.new(id: user.id)) }
    #  it { should be_able_to(:read, Order.new(user_id: user.id)) }
    #end
  end
end
