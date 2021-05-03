class ApplicationController < ActionController::API
    #before_action :return_not_found

    private
    def return_not_found
        render json: {description: "Not found"}, status: :not_found and return
    end

    def return_bad_request
        render json: {description: "Bad request"}, status: :not_found and return
    end

    def get_identificador(name)
        encoded_name = Base64.encode64(name)[0, 22]
        #puts "len of identifier: ",  encoded_name.length
        return encoded_name

    end


end
