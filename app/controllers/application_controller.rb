require './config/environment'
#require 'rack-flash'
class ApplicationController < Sinatra::Base
  set :method_override, true
#enable :sessions
#se Rack::Flash, :sweep => true #This will sweep stale flash entries, whether or not you actually use them.

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
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]  #if @current_user returns false, calls User.find_by_id if User.id exists in session hash.
    end

    def logged_in?
      !!current_user #since current_user returns true, !current_user would make current_user false, but !!current_user makes it true. Basically user is logged in if user is "not not the current user"
    end
    
    def authorized_to_edit?(liquor)
      liquor.user == current_user
  end
  
  # helpers do
  #   def current_user
  #     session[:user_id]
  #   end
    
  #   def logged_in?
  #     session[:user_id] = User.id
  #   end
  # end
end
