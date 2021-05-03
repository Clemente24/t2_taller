class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :albums, :tracks, :self

  def albums
    "https://fathomless-plateau-68297.herokuapp.com/artists/#{object.id}/albums"
  end

  def tracks
    "https://fathomless-plateau-68297.herokuapp.com/artists/#{object.id}/tracks"
  end

  def self
    "https://fathomless-plateau-68297.herokuapp.com/artists/#{object.id}"
  end

end
