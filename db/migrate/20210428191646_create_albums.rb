class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :genre
      t.timestamps
      t.references :artist, index: true, type: :string, foreign_key: true

    end
  end
end
