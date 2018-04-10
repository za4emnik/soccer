require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe '#show' do
    let (:team) { FactoryBot.create(:team) }
    subject { get :show, params: { id: team.first_member.id } }

      context 'when user' do
        login_user

        it_behaves_like 'controller have variables', 'teams': ActiveRecord::Relation
      end

      it_behaves_like 'guest'
  end
end
