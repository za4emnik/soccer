class Admin::VotesController < Admin::AdminBaseController
  load_and_authorize_resource :tournament

  def update
    @tournament.vote.close!
    redirect_to admin_tournaments_path
  end
end
