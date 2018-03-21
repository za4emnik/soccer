class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.string :aasm_state

      t.timestamps
    end
  end
end
