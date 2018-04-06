class AddInitialRatingToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :initial_rating, :float
  end
end
