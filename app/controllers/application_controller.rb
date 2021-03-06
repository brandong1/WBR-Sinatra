require './config/environment'
#require 'rack-flash'
class ApplicationController < Sinatra::Base
  set :method_override, true
#enable :sessions
#use Rack::Flash, :sweep => true #This will sweep stale flash entries, whether or not you actually use them.

  #From Sinatra README - ruby -e "require 'securerandom'; puts SecureRandom.hex(64)" to generate session_secret
  configure do
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
  end

  get "/" do
    erb :welcome
  end

  helpers do
    
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])  
    end

    def logged_in?
      !current_user.nil? 
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/'
      end
    end

  end
end
