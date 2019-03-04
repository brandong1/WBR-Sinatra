class UserController < ApplicationController
    
    get '/signup' do 
        if logged_in?
            redirect back
        else
            redirect :'/'
        end
    end

    post '/signup' do 
        #if username and pw are not blank, create user, save user, redirect to liquor index
        if !params[:username].empty? && !params[:password].empty?
                @user = User.new(username: params[:username], email: params[:email], password: params[:password])
                @users = User.all
                @user.save
                session[:user_id] = @user.id
                erb :'/users/show'
        else
            redirect '/' #flash message here?
        end
    end

    patch '/signup' do
        if logged_in?
            @user = current_user
            @user.update(name: params[:name], email: params[:email], password: params[:password])
            @user.save
            redirect back
        end
    end

    get '/login' do
        if logged_in?
            redirect '/users/show'
        else
            redirect '/' #add flash message about logging in?
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenicate(params[:password])
            session[:user_id] = @user.id
            redirect :'/liquors'
        else
            redirect :'/'
        end
    end

    get '/user/:slug' do
        @user = User.find_by_slug(params[:slug])
        @user = current_user
        erb :'/users/show'
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