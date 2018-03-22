class CreateTournaments < ActiveRecord::Migration[5.1]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :number_of_rounds
      t.string :aasm_state
      t.timestamps
    end
  end
end
