class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :first_team, references: :teams
      t.references :second_team, references: :teams
      t.string :type
      t.integer :position
      t.string :aasm_state

      t.timestamps
    end
  end
end
