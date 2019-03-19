class LiquorController < ApplicationController
    
    get '/liquors' do
        @liquors = Liquor.all
        erb :'/liquors/show'
    end

    get '/liquors/new' do
        if logged_in?
            erb :'/liquors/new'
        else
            redirect '/'
        end
    end

    # get '/liquors/:slug' do
    #     @song = Liquor.find_by_slug(params[:slug])
    #     erb :'/liquors/show'
    # end

    get '/liquors/liquor_show' do
        
        erb :'/liquors/liquor_show'

    end

    post '/liquors/show' do
        if  !params[:name].empty? &&
            !params[:description].empty? &&
            !params[:price].empty?
            @user = User.find_by_id(session[:user_id])
            Liquor.create(name: params[:name], description: params[:description], price: params[:price], user_id: @user.id)
            @liquors = current_user.liquors
                        #binding.pry
                erb :'/users/show'
        else
            redirect '/liquors/new'
        end
    end

    get '/liquors/:id/edit' do
        if logged_in?
            @liquors = Liquor.find_by_id(params[:id])     
            if @liquors && @liquors.user == current_user
                erb :'/liquors/edit'
            end
        else
            redirect '/'
        end
    end
    
    patch '/liquors/:id/edit' do 
        # @liquors.update(name: params[:name]...)
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
    delete '/liquors/:id' do
        if logged_in?
          @user = current_user
          @liquor = Liquor.find(params[:id])
          if @liquor.user_id == current_user.id
             @liquor = Liquor.delete(params[:id])
             redirect '/liquors'
          else
            redirect '/liquors'
          end
        else
          redirect back
        end
    end
end
