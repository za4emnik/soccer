class Admin::MatchesController < Admin::AdminBaseController
  load_and_authorize_resource :tournament
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  def index
    @matches = Match.with_filter(@tournament.matches, params[:match_search])
  end

  def show
  end

  def new
    @match = Match.new(tournament: @tournament)
  end

  def edit
  end

  def create
    if @tournament.matches.create(match_params)
      @tournament.processed! if @tournament.new?
      redirect_to admin_tournament_matches_path
    end
  end

  def update
    @match.scores.delete_all
    #score = Score.new(match: @match, team_id: params[:winner])
    @match.update_attributes(match_params)
    redirect_to admin_tournament_matches_path# if score.save
  end

  def destroy
    @match.destroy
    redirect_to admin_tournament_matches_path
  end

  def generate_matches
    service_generator = GenerateMatchesService.new(@tournament)
    service_generator.generate()
    redirect_to admin_tournament_matches_path
  end

  def sort
    params[:match].each_with_index do |id, index|
      Match.where(id: id).update_all(position: index+1)
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
