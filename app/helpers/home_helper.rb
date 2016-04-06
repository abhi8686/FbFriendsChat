module HomeHelper
	def to_rad(angle)
       angle * Math::PI / 180 
    end

	def dist(fbid)
		@me_latitude = current_user.latitude
		@me_longitude = current_user.longitude
		
		@friendDetail = User.find_by_uid(fbid)
		
		if !@friendDetail.latitude.nil?
			@frd_latitude = @friendDetail.latitude
			@frd_longitude = @friendDetail.longitude
			
			radius = 6371
		    lat1 = self.to_rad(@me_latitude)
		    lat2 = to_rad(@frd_latitude)
		    lon1 = to_rad(@me_longitude)
		    lon2 = to_rad(@frd_longitude)
		    dLat = lat2-lat1  
		    dLon = lon2-lon1
		    a = Math::sin(dLat/2) * Math::sin(dLat/2) +
		       Math::cos(lat1) * Math::cos(lat2) * 
		       Math::sin(dLon/2) * Math::sin(dLon/2);
		    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a));
		    @d = (radius * c).round
		else
			@d = ''
		end    
	    return @d
    end
end
