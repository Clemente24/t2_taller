class Artist < ApplicationRecord
    has_many :tracks, :dependent => :destroy
    has_many :albums, :dependent => :destroy
    #attr_accessor :artist_name, :artist_age, :artista_id, :unique_id

    
end
