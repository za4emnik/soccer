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

  # def update_list_of_players
    # @tournament.users.delete_all
    # @tournament.users << User.where(id: params[:users_ids])
    # redirect_to admin_tournament_players_path(@tournament.id)
  # end

  private

  def add_player(player)
    @tournament.users << player if player.present?
  end
end
