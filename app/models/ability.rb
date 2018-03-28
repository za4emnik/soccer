class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.is_admin?
    can :read, :all if user
    can [:edit, :update], Team, first_member_id: user.id
    can [:edit, :update], Team, second_member_id: user.id
  end
end
