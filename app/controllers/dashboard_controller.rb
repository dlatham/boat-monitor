class DashboardController < ApplicationController
	def main
		# Get the temperature card contents
		@temperature = Hash.new
		@temperature[:inside] = getInsideTemp
		@temperature[:outside] = getOutsideTemp

		#TODO assign the time zone to the user profile
		Time.zone = "Pacific Time (US & Canada)"

		# Get the last time the bilge ran
		@bilge = getBilgeStatus

	end

private
	def getInsideTemp
		# Return a temparature unless it's more than 1 hour old
		@temp = Heartbeat.last
		if @temp.created_at < 1.hours.ago
			return {temp: "N/A", last_update: @temp.created_at}
		else
			return {temp: "#{@temp.temp}&deg;", last_update: @temp.created_at}
		end
	end

	def getOutsideTemp
		#TODO use darksky API to get the current temp at the stored lat/long
		return {temp: "72&deg;", last_update: Time.now}
	end

	def getBilgeStatus

	end

end
