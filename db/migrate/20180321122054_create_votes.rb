class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :tournament, foreign_key: true
      t.string :aasm_state
      t.timestamps
    end
  end
end
