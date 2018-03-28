class HomeController < ApplicationController

  def index
    second_member = Team.where(second_member: current_user)
    @teams = Team.where(first_member: current_user).or(second_member)
  end
end
