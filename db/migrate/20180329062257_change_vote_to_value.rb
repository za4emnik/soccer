class ChangeVoteToValue < ActiveRecord::Migration[5.1]
  def change
    rename_column :vote_items, :vote, :value
  end
end
