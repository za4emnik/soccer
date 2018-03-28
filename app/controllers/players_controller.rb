class PlayersController < ApplicationController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :user, through: :tournament
end
