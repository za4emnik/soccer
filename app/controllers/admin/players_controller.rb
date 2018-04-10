class Admin::PlayersController < Admin::AdminBaseController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :user, through: :tournament

  def new
    @users = User.all
  end

  def destroy
    @tournament.users.delete(User.find(params[:id]))
    redirect_to admin_tournament_players_path
  end

  def update_list_of_players
    @tournament.users.delete_all
    @tournament.users << User.where(id: params[:users_ids])
    redirect_to admin_tournament_players_path(@tournament.id)
  end
end
