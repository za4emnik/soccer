class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.is_admin?
    can :read, [Tournament, Match, Team, User] if user
    can :read, Vote do |vote|
      vote.new?
    end
    can [:edit, :update], Team, first_member_id: user.id
    can [:edit, :update], Team, second_member_id: user.id
  end
end
