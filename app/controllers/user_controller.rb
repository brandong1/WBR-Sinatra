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
                if @user.save
                session[:user_id] = @user.id
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
            redirect "/users/#{current_user.id}"
        else
            redirect '/' 
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/home'
        else
            redirect '/'
        end
    end

    get '/users' do #RESTful
        @user = current_user
        @users = User.all
        erb :'/users/index'
    end

    get '/users/:id' do #RESTful
        if logged_in?
             @user = User.find(params[:id]) 
             @liquors = @user.liquors
             
             erb :'/users/show'
         else
             redirect :'/users/index'
        end
    end
 
    # get '/users/index' do
    #     if logged_in?
    #         @user = current_user
    #         @users = User.all
    #         session[:user_id] = @user.id
    #         @user.email = current_user.email
    #         @user.password = current_user.password
    #         @liquors = Liquor.all
    #         erb :'/users/index' 

    #     else
    #         redirect '/'
    #     end
    # end

    get '/users/:id/edit' do #RESTful
        @user = User.find_by(id: params[:id])
        erb :'/users/edit'
    end

    # get '/users/edit' do
    #     @user = User.find_by(username: params[:username])
    #     @user = current_user.username
    #     session[:user_id] = current_user.id
        
    #     erb :'/users/edit'
    # end

    patch '/users/:id' do #done
        if logged_in?
            @user = User.find(params[:id])
            if @user == current_user
                @user.update(email: params[:email], password: params[:password])
                @user.save
            end
            redirect to :'/users'
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
