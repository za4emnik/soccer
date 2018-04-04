class HomeController < ApplicationController

  def index
    @teams = Team.with_user(current_user)
  end
end
