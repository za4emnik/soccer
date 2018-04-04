class PlayersController < ApplicationController
  load_and_authorize_resource :tournament
end
