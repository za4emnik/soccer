class ChangeMatchesTypeToMatchType < ActiveRecord::Migration[5.1]
  def change
    rename_column :matches, :type, :match_type
  end
end
