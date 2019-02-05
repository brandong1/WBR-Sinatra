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
        if !params[:username].empty? && !params[:password].empty?
            @user = User.new(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
            if @user.save
                session[:user_id] = @user.id
                redirect :'/liquors'
            else
                redirect '/' #flash message here?
            end
        else
            redirect '/'
        end
    end

    get '/login' do
        if logged_in?
            redirect #WHERE??
        else
            redirect '/' #add flash message about logging in
        end
    end

    post '/login' do
        
    end

    get '/user/:slug' do
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/'
        else
            redirect '/'
        end
    end
end