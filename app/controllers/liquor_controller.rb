class LiquorController < ApplicationController
    
    get '/liquors' do
        @liquors = Liquor.all
        erb :'/liquors/liquors'
    end

    get '/liquors/new' do
        @user = current_user
        erb :'/liquors/new'
    end

    # get '/liquors/:slug' do
    #     @song = Liquor.find_by_slug(params[:slug])
    #     erb :'/liquors/show'
    # end

    post '/liquors/new' do
        if  !params[:name].empty? &&
            !params[:description].empty? &&
            !params[:price].empty?
                @user = current_user
                @liquor = Liquor.new(name: params[:name], description: params[:description], price: params[:price])
                @liquors = Liquor.all
                @liquor.save
                erb :'/liquors/show'
        else
            redirect '/liquors/new'
        end
    end


end