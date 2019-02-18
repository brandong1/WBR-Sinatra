class LiquorController < ApplicationController
    
    get '/liquors' do
        if logged_in?
            @user = current_user
            @liquors = Liquor.all
            erb :'liquors/liquors'
        else
            redirect '/'
        end
    end

    get '/liquors/new' do
        if logged_in?
            @user = current_user
            erb :'liquors/new'
        else
            redirect '/'
        end
    end







end