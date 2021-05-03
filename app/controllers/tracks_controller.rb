class TracksController < ApplicationController
    
    #GET /tracks
    # GET /albums/:album_id/tracks

    def index
        if !params[:album_id].blank?
            @tracks = Track.where(album_id: params[:album_id])
            if !@tracks.first
                return_not_found
            else
                render json: @tracks, status: 200 and return
            end
        elsif !params[:artist_id].blank?
            @tracks = Track.where(artist_id: params[:artist_id])
            if !@tracks.first   
                return_not_found
            else
                render json: @tracks, status: 200 and return
            end
        else
            @tracks = Track.all
            if @tracks
                render json: @tracks, status: 200 and return
            else
                return_not_found
            end
        end     
    end

    # GET /tracks/:id
        # Obtiene track por id
        def show
            @track = Track.where(id: params[:id]).first
            if @track
                render json: @track, status: 200
            else
                return_not_found
            end    
        end

    # POST /albums/:album_id/tracks 
    def create
        # Si el input esta "OK"
        duracion = params[:duration].to_f

        if !params[:name].blank? && !params[:duration].blank? && params[:name].is_a?(String) && duracion.is_a?(Float)
            
            @album = Album.where(id: params[:album_id]).first
            
            # Chequear si el album existe:    
            if @album
                identificador_track = get_identificador("#{params[:name]}:#{@album.id}").strip
                @artist = Artist.where(id: @album.artist_id).first
                @track = Track.where(id: identificador_track).first
  
                # Si existe track, error 409
                if @track
                    @track.artist_id = @artist.id
                    render json: @track, status: 409
                else 
                    # Crear track
                    @track = Track.new(name: params[:name], duration: duracion, id: identificador_track, times_played: 0, album_id: @album.id)
                    @track.artist_id = @artist.id
                    #puts "track.artist_id: ", @track.artist_id

                    # Intentar guardar track
                    if @track.save
                        render json: @track, status: 201
                    else
                        render json: {description: 'Error inesperado'}, status: 400
                    end
                end
            else
               render json: {description: "No existe album indicado"}, status: 422 
            end
        else
            # Input invalido
            render json: {description: 'Input inválido'}, status: 400
            
        end
    end

    # PUT /tracks/:id/play
    def play
        #puts "play song with id: ", params[:track_id]
        @track = Track.where(id: params[:track_id]).first
        if @track
            @track.times_played += 1
            @track.save
            render json: {description: "Canción reproducida"}, status: 200
        else
            return_not_found
        end
    end

    # DELETE /tracks/:track_id
    def destroy
        puts "params destroy track; ", params
        @track = Track.where(id: params[:id]).first
        if @track
            @track.destroy
            render json: {}, status: 204
        else
            return_not_found
        end
    end
end
