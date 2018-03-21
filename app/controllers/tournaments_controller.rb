class TournamentsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    Tournament.create(tournament_params)
  end

  def update
  end

  def destroy
  end

  private

  def tournaments_params
    params.require(:tournament).permit(:name)
  end
end
