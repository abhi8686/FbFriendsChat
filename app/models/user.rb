class User < ActiveRecord::Base

	attr_accessible :provider, :uid, :name, :oauth_token, :oauth_expires_at, :latitude, :longitude
  has_many :conversations, :foreign_key => :sender_id
	
  serialize :multi_friends, Hash
  
  has_many :invitefriends
	def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
