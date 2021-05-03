class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.integer :age

      t.timestamps
    end
  end
end
