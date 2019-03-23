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
                if @user.save
                # binding.pry
                session[:user_id] = @user.id
                @liquors = Liquor.all
                redirect to '/views/index'
                else
                    puts "Error #{@user.errors}"
                    redirect '/signup' 
                end
        else
            redirect '/' #flash message here?
        end
    end

    # patch '/signup' do
    #     if logged_in?
    #         @user = current_user
    #         @user.update(name: params[:name], email: params[:email], password: params[:password])
    #         @user.save
    #         erb :'users/show'
    #     # else
    #     #     flash[:message] = "Please try again."
    #     end
    # end

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
            @users = User.all
            @liquors = Liquor.all
            erb :'/users/index'
        else
            redirect :'/'
        end
    end

    get '/users' do
        #@user.username = User.find_by(username: params[:username])
        @users = User.all
        @liquors = Liquor.all
        #binding.pry
        redirect :'/users/index'
    end

    get '/users/show' do
        if logged_in?
             @user = current_user #need to fix this to show whichever user's show page
            # @user == current_user
            @liquors = current_user.liquors
            #binding.pry
                # if @liquors && @liquors.user == current_user
            # @user = User.find_by(username: params[:username])
                erb :'/users/show'
                 else
                    redirect :'/users/index'
            # @savings = SavingsAccount.find_by_id(params[:id])
            #       if @savings && @savings.user == current_user         
            # erb :'savings_accounts/edit' 
        end
    end
    
    #post '/users/'
    # get '/:username' do
    #     if logged_in?
    #         @user = current_user
    #         erb :'/users/show'
    #     else
    #         redirect '/'
    #     end
    # end

    get '/users/index' do
        if logged_in?
            @user = current_user
            @users = User.all
            session[:user_id] = @user.id
            @user.email = current_user.email
            @user.password = current_user.password
            @liquors = Liquor.all
            erb :'/users/index' 
            #binding.pry
        else
            #flash[:message] = "You must be logged in to view this page!"
            redirect '/'
        end
    end

    post '/users/:id' do
        @user = User.find_by_id(id: params[:id])
        session[:user_id] = @user.id
        erb :'/users/show'
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
            @user.save
            erb :'/users/show'
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