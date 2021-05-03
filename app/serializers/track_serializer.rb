class TrackSerializer < ActiveModel::Serializer
  attributes :id, :name, :album_id, :duration, :times_played, :artist, :album, :self

  def artist
    "https://fathomless-plateau-68297.herokuapp.com/artists/#{object.artist_id}/albums"
  end

  def album
    "https://fathomless-plateau-68297.herokuapp.com/albums/#{object.album_id}"
  end

  def self
    "https://fathomless-plateau-68297.herokuapp.com/tracks/#{object.id}"
  end

end
