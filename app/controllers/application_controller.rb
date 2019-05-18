class ApplicationController < ActionController::Base

	helper_method :device_location, :local?, :remote?

	def device_location
		@location ||= cookies[:local_device]
		#puts "The local_device variable = #{@location}"
	end

	def local?
		if device_location == "true"
			true
		else
			false
		end
	end

	def remote?
		!device_location
	end

end
