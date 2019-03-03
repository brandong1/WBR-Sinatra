class LiquorController < ApplicationController
    
    get '/liquors' do
        @liquors = Liquor.all
        erb :'/liquors/liquors'
    end

    get '/liquors/new' do
        erb :'/liquors/new'
    end

    # get '/liquors/:slug' do
    #     @song = Liquor.find_by_slug(params[:slug])
    #     erb :'/liquors/show'
    # end

    post '/liquors/new' do
        @liquors = Liquor.create(name: params['Name'])
        @liquor.user = User.find_or_create_by(name: params['User Name'])
        @liquor.save
    end


end