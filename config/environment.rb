ENV['SINATRA_ENV'] ||= "development"
ENV['SESSION_SECRET'] ||= "d@h33t"
SINATRA_ACTIVESUPPORT_WARNING=false

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller'
#require 'rack-flash'
require_all 'app'
