require './config/environment'

class ApplicationController < Sinatra::Base

  #From Sinatra README - ruby -e "require 'securerandom'; puts SecureRandom.hex(64)" to generate session_secret
  configure do
    enable :sessions
    set :session_secret, "861dee66e3c36900c4443ec8e6a7831ec688729aa9e5962b9c7d91e6cd32f3613f27d9241846eec8f74f81a1bc90e65d9e7369430bb491d5cded59fa2849d3d4"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    if logged_in?
      redirect to '/liquors'
    else
      erb :welcome
    end
  end

end
