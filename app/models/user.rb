class User < ActiveRecord::Base
    has_many :liquors
    has_secure_password
    validates :username, uniqueness: :true
    #can this also be written as validates_uniqueness_of :username? or is this syntax rails?

    def slug
        username.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        User.find {|user| user.slug == slug }
    end
end
