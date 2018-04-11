class CreateJoinTableTournamentUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tournaments, :users do |t|
      t.index %i[tournament_id user_id]
      t.index %i[user_id tournament_id]
    end
  end
end
