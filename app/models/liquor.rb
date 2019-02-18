class Liquor < ActiveRecord::Base
    belongs_to :user
    #attr_accessor :name, :summary, :rating
end
