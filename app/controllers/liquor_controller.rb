class LiquorController < ApplicationController
    
    get '/liquors' do
        @liquors = Liquor.all
        erb :'/liquors/index'
    end

    get '/liquors/new' do
        redirect_if_not_logged_in
        erb :'/liquors/new'
    end

    get '/users/show' do
        redirect_if_not_logged_in
        @liquors = current_user.liquors
        erb :'/users/show'
    end

    post '/liquors/show' do
        if  !params[:name].empty? &&
            !params[:description].empty? &&
            !params[:price].empty?
            @user = User.find_by_id(session[:user_id])
            Liquor.create(name: params[:name], description: params[:description], price: params[:price], user_id: @user.id)
            @liquors = current_user.liquors
                        #binding.pry
                redirect to '/users/show'
        else
            redirect '/liquors/new'
        end
    end

    get '/liquors/:id/edit' do
        if logged_in?
            @liquors = Liquor.find_by_id(params[:id])     
            if @liquors && @liquors.user == current_user
                erb :'/liquors/edit'
            else 
                redirect '/liquors'
            end
        else
            redirect '/'
        end
    end
    
    patch '/liquors/:id' do 
        @liquors = Liquor.find_by_id(params[:id])
            @user = User.find_by_id(session[:user_id])
            if @liquors && @liquors.user == @user
        @liquors.update(name: params[:name], description: params[:description], price: params[:price])
        redirect '/users/show'
            else
            redirect '/'
            end
    end

    get '/liquors/:id/delete' do
    if logged_in?
        @liquors = Liquor.find_by_id(params[:id])
            if @liquors && @liquors.user == current_user
                erb :'liquors/delete'
            else
                redirect to '/users/show'
            end
        else
                redirect '/'
        
        end
    end
    delete '/liquors/:id/delete' do
        if logged_in?
          @user = current_user
          #@user = User.find_by_id(session[:user_id])
          @liquor = Liquor.find(params[:id])
          if @liquor && @liquor.user == @user
            @liquor.delete
             redirect '/users/show'
          else
            redirect back
          end
        end
    end
end
