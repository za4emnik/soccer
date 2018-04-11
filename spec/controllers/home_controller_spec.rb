require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe '#index' do
    subject { get :index }

    context 'when user' do
      login_user

      before do
        FactoryBot.create(:team, first_member: @logged_user)
      end

      it_behaves_like 'controller have variables', 'tournaments': ActiveRecord::Relation,
                                                   'teams': Array
    end

    it_behaves_like 'guest'
  end
end
