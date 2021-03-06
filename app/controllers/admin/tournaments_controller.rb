class Admin::TournamentsController < Admin::AdminBaseController
  load_and_authorize_resource param_method: :tournament_params

  def index
    @tournaments = Tournament.with_filter(Tournament.all, params[:tournament_search])
  end

  def create
    if @tournament.save
      redirect_to admin_tournaments_path
    else
      render :new
    end
  end

  def update
    if @tournament.update_attributes(tournament_params)
      redirect_to admin_tournament_path
    else
      render :new
    end
  end

  def destroy
    @tournament.destroy
    redirect_to admin_tournaments_path
  end

  def done
    @tournament.complete!
    redirect_to admin_tournament_path
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :number_of_rounds)
  end
end
