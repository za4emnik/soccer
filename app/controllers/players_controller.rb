class PlayersController < ApplicationController
  load_and_authorize_resource :tournament

  def index
    @players = @tournament.users.page params[:page]
  end
end
