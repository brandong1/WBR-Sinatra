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