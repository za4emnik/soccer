class MatchesController < ApplicationController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :match, through: :tournament
end
