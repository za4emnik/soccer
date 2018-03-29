class VotesController < ApplicationController
  load_and_authorize_resource :tournament

  def show
    authorize! :read, @tournament.vote
    @players = @tournament.users.joins("LEFT JOIN vote_items ON (vote_items.vote_user_id = users.id AND vote_items.vote_id = #{@tournament.vote.id} AND vote_items.user_id = #{current_user.id})").order('vote_items.value DESC')
  end

  def sort
    @vote_items = @tournament.vote.vote_items
    params[:user].reverse!.each_with_index do |id, index|
      item = @vote_items.where(vote_user_id: id, user: current_user).first_or_initialize
      item.value = index + 1
      item.save
    end
  end
end
