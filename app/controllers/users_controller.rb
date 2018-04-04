class UsersController < ApplicationController
  load_and_authorize_resource :user

  def show
    @teams = Team.with_user(@user)
  end
end
