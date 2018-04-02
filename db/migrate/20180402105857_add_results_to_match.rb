class AddResultsToMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :first_team_result, :integer
    add_column :matches, :second_team_result, :integer
  end
end
