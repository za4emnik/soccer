require 'rails_helper'

RSpec.describe GenerateRatingsService do
  context '#initialize' do
    let(:vote) { FactoryBot.create(:vote) }
    subject { GenerateRatingsService.new(vote) }

    it_behaves_like 'controller have variables', 'vote': Vote, 'tournament': Tournament,
                                                 'users': ActiveRecord::Relation do
      let(:controller) { subject }
    end
  end

  context '#call' do
    let(:tournament) { FactoryBot.create(:tournament) }
    let(:vote) { FactoryBot.create(:vote, tournament: tournament) }
    let(:user) { FactoryBot.create(:user) }
    subject { GenerateRatingsService.new(vote) }

    before do
      4.times do
        tournament.users << FactoryBot.create(:vote_item, vote: vote, user: user).user
      end
    end

    it 'should call #create_rating_for method a certain number of times' do
      expect(subject).to receive(:create_rating_for).exactly(tournament.users.count).times
      subject.call
    end

    it_behaves_like 'controller have variables', 'vote': Vote, 'tournament': Tournament,
                                                 'users': ActiveRecord::Relation do
      let(:controller) { subject }
    end
  end

  context '#rating_value_for' do
    let(:tournament) { FactoryBot.create(:tournament) }
    let(:vote) { FactoryBot.create(:vote, tournament: tournament) }
    let(:user) { FactoryBot.create(:user) }
    subject { GenerateRatingsService.new(vote) }

    before do
      3.times do
        tournament.users << FactoryBot.create(:vote_item, vote: vote, user: user).vote_user
      end
    end

    it 'should return instance of integer' do
      test_user = FactoryBot.create(:user)
      tournament.users << FactoryBot.create(:vote_item, vote: vote, user: user, vote_user: test_user).vote_user
      expect(subject.rating_value_for(test_user)).to be_an(Integer)
    end

    it 'should return sum of values for ratings' do
      test_user = FactoryBot.create(:user)
      tournament.users << FactoryBot.create(:vote_item, vote: vote, user: user, vote_user: test_user, value: 1).vote_user
      tournament.users << FactoryBot.create(:vote_item, vote: vote, user: user, vote_user: test_user, value: 2).vote_user
      expect(subject.rating_value_for(test_user)).to eq(3)
    end

    it_behaves_like 'controller have variables', 'vote': Vote, 'tournament': Tournament,
                                                 'users': ActiveRecord::Relation do
      let(:controller) { subject }
    end
  end

  context '#rating_for' do
    let(:tournament) { FactoryBot.create(:tournament) }
    let(:vote) { FactoryBot.create(:vote, tournament: tournament) }
    let(:user) { FactoryBot.create(:user) }
    subject { GenerateRatingsService.new(vote) }

    before do
      3.times do
        tournament.users << FactoryBot.create(:vote_item, vote: vote, user: user).vote_user
      end
    end

    it 'should return instance of Rating' do
      expect(subject.rating_for(vote.vote_items.first.vote_user)).to be_an(Rating)
    end

    it_behaves_like 'controller have variables', 'vote': Vote, 'tournament': Tournament,
                                                 'users': ActiveRecord::Relation do
      let(:controller) { subject }
    end
  end

  context '#create_rating_for' do
    let(:tournament) { FactoryBot.create(:tournament) }
    let(:vote) { FactoryBot.create(:vote, tournament: tournament) }
    let(:user) { FactoryBot.create(:user) }
    subject { GenerateRatingsService.new(vote) }

    before do
      3.times do
        tournament.users << FactoryBot.create(:vote_item, vote: vote, user: user).vote_user
      end
    end

    it 'should create rating for user in tournament' do
      user = vote.vote_items.first.user
      expect { subject.create_rating_for(user) }.to change { user.ratings.where(tournament: tournament).count }.from(0).to(1)
    end

    it_behaves_like 'controller have variables', 'vote': Vote, 'tournament': Tournament,
                                                 'users': ActiveRecord::Relation do
      let(:controller) { subject }
    end
  end
end
