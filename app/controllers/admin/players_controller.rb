class Admin::PlayersController < Admin::AdminBaseController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :user, through: :tournament

  def index
  end

  def show
  end

  def new
    @users = User.all
  end

  def edit
  end

  def create
    #if @tournament.users.save
    #  redirect_to admin_tournament_path(@tournament)
    #else
    #  render(:new)
    #end
  end

  def update
    #if @tournament.update_attributes(tournament_params)
    #  redirect_to admin_tournament_path(@tournament)
    #else
    #  render(:new)
    #end
  end

  def destroy
    #@tournament.destroy
    #redirect_to admin_tournaments_path
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :number_of_rounds)
  end
end
