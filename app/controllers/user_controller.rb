class UserController < ApplicationController
    
    get '/signup' do 
        if logged_in?
            redirect :'/views/liquors'
        else
            redirect :'/signup'
        end
    end

    post '/signup' do 
        #if username and pw are not blank, create user, save user, redirect to liquor index
    end

    get '/login' do
    end

    post '/login' do
    end

    get '/user/:slug' do
    end

    get '/logout' do
    end
end