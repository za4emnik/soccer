class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :tournament, foreign_key: true
      t.references :user, foreign_key: true
      t.float :rating

      t.timestamps
    end
  end
end
