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
            erb :'users/show'
        # else
        #     flash[:message] = "Please try again."
        end
    end

    get '/views/index' do
        @user = current_user
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
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect :'/views/index'
        else
            redirect :'/'
        end
    end

    get '/users' do
        @users = User.all
        #binding.pry
        erb :'/users/index'
    end
    
    # get '/:username' do
    #     if logged_in?
    #         @user = current_user
    #         erb :'/users/show'
    #     else
    #         redirect '/'
    #     end
    # end

    get '/users/:id' do
        if logged_in?
            @user = current_user
            session[:user_id] = @user.id
            @user.email = current_user.email
            @user.password = current_user.password
            erb :'/users/edit'
            #binding.pry
        else
            #flash[:message] = "You must be logged in to view this page!"
            redirect '/'
        end
    end

    post '/users/:id' do
        # @user = User.find_by_id(id: params[:id])
        # session[:user_id] = @user.id
        erb :'/users/show'
    end

    get '/users/:id/edit' do
        @users = User.find(params.fetch[:id])
        erb :'/users/edit'
    end


    patch '/users/:id' do #done
            @user = current_user
            @user.update(email: params[:email], password: params[:password])
            @user.save
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