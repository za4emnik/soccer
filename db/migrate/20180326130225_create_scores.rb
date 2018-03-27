class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :score, default: 3
      t.references :team, foreign_key: true
      t.references :match, foreign_key: true
      t.timestamps
    end
  end
end
