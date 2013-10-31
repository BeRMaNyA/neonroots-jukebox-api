class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.integer :price_in_cents

      t.timestamps
    end

    add_index :songs, [:title, :artist, :album], name: "index_songs_on_title_and_artist_and_album", unique: true
    add_index :songs, [:price_in_cents], name: "index_songs_on_price_in_cents"
  end
end
