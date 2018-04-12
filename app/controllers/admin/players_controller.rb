class Admin::PlayersController < Admin::AdminBaseController
  load_and_authorize_resource :tournament
  load_and_authorize_resource :user, through: :tournament

  def index
    search = params[:player_search]&.[](:name)
    @players = @tournament.users.with_filter(search).page params[:page]
  end

  def new
    search = params[:player_search]&.[](:name)
    @players = User.all.with_filter(search).page params[:page]
  end

  def create
    user = User.find params[:player_id]
    add_player(user) if @tournament.users.where(id: params[:player_id]).blank?
    redirect_to new_admin_tournament_player_path
  end

  def destroy
    @tournament.users.delete(User.find(params[:id]))
    redirect_to new_admin_tournament_player_path
  end

  private

  def add_player(player)
    @tournament.users << player if player.present?
  end
end
