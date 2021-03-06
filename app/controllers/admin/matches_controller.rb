class Admin::MatchesController < Admin::AdminBaseController
  load_and_authorize_resource :tournament
  before_action :set_match, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token, only: :sort

  def index
    @matches = Match.with_filter(@tournament.matches, params[:match_search])
  end

  def new
    @match = Match.new(tournament: @tournament)
  end

  def create
    @match = @tournament.matches.new(match_params)
    if @match.save
      @tournament.processed! if @tournament.new?
      redirect_to admin_tournament_matches_path
    else
      render :new
    end
  end

  def update
    if @match.update_attributes(match_params)
      redirect_to admin_tournament_matches_path
    else
      render :edit
    end
  end

  def destroy
    @match.destroy
    redirect_to admin_tournament_matches_path
  end

  def generate_matches
    service_generator = GenerateMatchesService.new(@tournament)
    service_generator.generate
    redirect_to admin_tournament_matches_path
  end

  def sort
    params[:match].each_with_index do |id, index|
      Match.where(id: id).update_all(position: index + 1)
    end
  end

  private

  def match_params
    params.require(:match).permit(:first_team_id, :second_team_id, :match_type, :first_team_result, :second_team_result)
  end

  def set_match
    @match = Match.find params[:id]
  end
end
