class UserController < ApplicationController
    
    get '/signup' do 
        if logged_in?
            redirect '/views/index'
        else
            redirect '/'
        end
    end

    post '/signup' do 
        #if username and pw are not blank, create user, save user, redirect to liquor index
        if !params[:username].empty? && !params[:password].empty?
                @user = User.new(username: params[:username], email: params[:email], password: params[:password])
                @users = User.all
                @user.save
                session[:user_id] = @user.id
                @liquors = Liquor.all
                redirect to '/views/index'
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

    get '/views/index' do
        erb :index
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

    get '/users' do
        @users = User.all
        erb :'/users/index'
    end
    
    get '/:username' do
        if logged_in?
            @user = current_user
            erb :'/users/show'
        else
            redirect '/'
        end
    end

    get '/:username/edit' do
        if logged_in?
            erb :"/users/edit"
        else
            flash[:message] = "You must be logged in to view this page!"
            redirect '/'
        end
    end

    # patch '/:username/edit' do
    #     if !logged_in?
    #         redirect '/'
    #     else
    #         @user = current_user
    #         @user.username = params[:username]
    #         @user.email = params[:email]
    #         @user.password = params[:password]
    #         @user.save
    #         redirect '/'
    #     end
    # end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/'
        else
            redirect '/'
        end
    end
end