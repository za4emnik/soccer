class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :first_member, references: :users
      t.references :second_member, references: :users
      t.timestamps
    end
  end
end
