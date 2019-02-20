class LiquorController < ApplicationController
    
    get '/liquors' do
        @liquors = Liquor.all
        erb :'/'
    end

    get '/liquors/new' do
        erb :'/liquors/new'
    end

    
end