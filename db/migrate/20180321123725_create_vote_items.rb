class CreateVoteItems < ActiveRecord::Migration[5.1]
  def change
    create_table :vote_items do |t|
      t.references :user, foreign_key: true
      t.references :vote_user, references: :users
      t.decimal :vote, precision: 8, scale: 2
      t.references :vote, foreign_key: true

      t.timestamps
    end
  end
end
