class UserController < ApplicationController
    
    get '/signup' do 
        if logged_in?
            redirect :'/views/liquors'
        else
            redirect :'/signup'
        end
    end
end