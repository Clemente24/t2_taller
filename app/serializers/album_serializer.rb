class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :genre, :artist, :tracks, :self
  
  def artist
    "https://fathomless-plateau-68297.herokuapp.com/artists/#{object.artist_id}"
  end

  def tracks
    "https://fathomless-plateau-68297.herokuapp.com/albums/#{object.id}/tracks"
  end

  def self
    "https://fathomless-plateau-68297.herokuapp.com/albums/#{object.id}"
  end




end
