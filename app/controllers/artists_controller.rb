class ArtistsController < ApplicationController

    # GET /artists
    # Obtiene todos los artistas
    def index
        @artists = Artist.all
        if @artists
            render json: @artists, status: 200 and return
        else
            return_not_found
        end
    end

    
    # GET /artists/:id
    # Obtiene artista por id
    def show
        
        @artist = Artist.where(id: params[:id]).first
        if @artist 
            render json: @artist, status: 200
        else
            #render error: {error: 'Artist not found'}, status: 404
            return_not_found
            # format.any { render :json => {:response => 'Artista not found' }, :status => 404  }
    
        end
    end


    # POST /artists
    def create
        puts "tipo de name: %s, tipo de age: %s" % [params[:name].class.to_s, params[:age].class.to_s] 

        # Si el input esta "OK"
        if !params[:name].blank? && !params[:age].blank? && params[:name].is_a?(String) && Float(params[:age], exception: false) 
            identificador = get_identificador(params[:name]).strip

            @artist = Artist.where(id: identificador).first

            # Si el artista ya existe:    
            if @artist
                render json:  @artist, status: 409
            
            else
                @artist = Artist.new(name: params[:name], age: params[:age], id: identificador)
                
                if @artist.save
                    render json: @artist, status: 201
                else
                    render json: {description: 'Error inesperado'}, status: 400
                end
            end
        else
            # Input invalido
            render json: {error: 'Input inválido'}, status: 400
            
        end
    end
    
    # PUT /artists/:id/albums/play
    def play
        puts "paramsss", params
        @tracks = Track.where(artist_id: params[:artist_id])
        puts "tracks de artista: ", @tracks
        if @tracks.first
            @tracks.each do |track|
                track.times_played += 1
                track.save
            end
            render json: {description: "Canciones del artista reproducidas"}, status: 200
        else
            return_not_found
        end
    end

    # DELETE /artists/:artist_id
    def destroy
        @artist = Artist.where(id: params[:id]).first
        if @artist
            @artist.destroy
            render json: {}, status: 204
        else
            return_not_found
        end
    end

    

end

