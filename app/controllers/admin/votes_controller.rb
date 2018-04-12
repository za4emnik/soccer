class Admin::VotesController < Admin::AdminBaseController
  load_and_authorize_resource :tournament

  def update
    @tournament.vote.close!
    redirect_to admin_tournament_path(@tournament)
  end
end
