class Admin::MatchesController < Admin::AdminBaseController
  load_and_authorize_resource :tournament

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def generate_matches
    service_generator = GenerateMatchesService.new(@tournament)
    service_generator.generate()
  end

  def generate_play_off
  end
end
