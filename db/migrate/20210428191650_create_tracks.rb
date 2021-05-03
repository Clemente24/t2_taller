class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.float :duration
      t.integer :times_played
      t.timestamps

      t.references :album, index: true, type: :string, foreign_key: true
      t.references :artist, index: true, type: :string, foreign_key: true
    end
  end
end
