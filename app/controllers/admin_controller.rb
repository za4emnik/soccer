class AdminController < ApplicationController
  before_action :authenticate_user!, :authorize_admin
  load_and_authorize_resource :users

  def index
  end

  private

  def authorize_admin
    authorize! :manage, :all
  end
end
