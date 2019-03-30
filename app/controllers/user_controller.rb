class UserController < ApplicationController

    get '/signup' do 
        if logged_in?
            redirect '/home'
        else
            redirect '/'
        end
    end

    post '/signup' do 
        #if username and pw are not blank, create user, save user, redirect to liquor index
        if !params[:username].empty? && !params[:password].empty?
                @user = User.new(username: params[:username], email: params[:email], password: params[:password])
                @users = User.all
                if @user.save
                session[:user_id] = @user.id
                @liquors = Liquor.all
                redirect to '/home'
                else
                    puts "Error #{@user.errors}" # this error will appear in the terminal
                    redirect '/signup' 
                end
        else
            redirect '/' 
        end
    end

    get '/home' do
        @user = current_user
        erb :index
    end

    get '/login' do
        if logged_in?
            redirect '/users/show'
        else
            redirect '/' 
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            @users = User.all
            @liquors = Liquor.all
            redirect '/home'
        else
            redirect '/'
        end
    end

    get '/users' do
        @users = User.all
        @liquors = Liquor.all
        redirect :'/users/index'
    end

    get '/users/show' do
        if logged_in?
             @user = current_user 
             @liquors = current_user.liquors
             erb :'/users/show'
         else
             redirect :'/users/index'
        end
    end
 
    get '/users/index' do
        if logged_in?
            @user = current_user
            @users = User.all
            session[:user_id] = @user.id
            @user.email = current_user.email
            @user.password = current_user.password
            @liquors = Liquor.all
            erb :'/users/index' 

        else
            redirect '/'
        end
    end

    post '/users/:id' do
        @user = User.find_by_id(id: params[:id])
        session[:user_id] = @user.id
        redirect to :'/users/show'
    end

    get '/users/edit' do
        @user = User.find_by(username: params[:username])
        @user = current_user.username
        
        erb :'/users/edit'
    end

    patch '/users/:id' do #done
        if logged_in?
            @user = current_user
            @user.update(email: params[:email], password: params[:password])
            @liquors = current_user.liquors
            @user.save
            redirect to :'/users/show'
        else
            redirect '/'
        end
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
