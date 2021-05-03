class AlbumsController < ApplicationController
    #before_action :get_artist

    # GET /albums, /artists/:artist_id/albums
    def index
        if params[:artist_id].blank?
            @albums = Album.all
            if @albums
                render json: @albums, status: 200 and return
            else
                return_not_found
            end
        else
            @albums = Album.where(artist_id: params[:artist_id])
            if !@albums.first
               return_not_found
            else
                render json: @albums, status: 200 and return
            end
        end
    end

    # GET /albums/:id
    # Obtiene album por id
    def show
        @album = Album.where(id: params[:id]).first
        if @album
            render json: @album, status: 200
        else
            return_not_found     
        end
    end

    # POST /album   
    def create
        # Si el input esta "OK"
        if !params[:name].blank? && !params[:genre].blank? && params[:name].is_a?(String) && params[:genre].is_a?(String) 
            
            @artist = Artist.where(id: params[:artist_id]).first
            
            # Chequear si el artista existe:    
            if @artist
                identificador_album = get_identificador("#{params[:name]}:#{@artist.id}").strip
                @album = Album.where(id: identificador_album).first
  
                # Si existe album, error 409
                if @album
                    render json: @album, status: 409
                else 
                    # Crear album
                    @album = Album.new(name: params[:name], genre: params[:genre], id: identificador_album, artist_id: params[:artist_id])

                    # Intentar guardar album
                    if @album.save!
                        render json: @album, status: 201
                    else
                        render json: {description: 'Error inesperado'}, status: 400
                    end
                end
            else
               render json: {description: "No existe artista indicado"}, status: 422 
            end
        else
            # Input invalido
            render json: {description: 'Input inválido'}, status: 400
            
        end
    end

    # PUT /albums/:id/tracks/play
    def play
        puts 'params en album', params
        @tracks = Track.where(album_id: params[:album_id])
        if @tracks.first
            @tracks.each do |track|
                track.times_played += 1
                track.save
            end
            render json: {description: "Canciones del álbum reproducidas"}, status: 200
        else
            return_not_found
        end
    end

    # DELETE /albums/:id
    def destroy
        @album = Album.where(id: params[:id]).first
        if @album
            @album.destroy
            render json: {}, status: 204
        else
            return_not_found
        end
    end
end
