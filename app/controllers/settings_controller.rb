class SettingsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_device_cookie, except: [:set_device_id]

	def index
		#show all the settings on one screen
		@device = cookies[:device_id]
		@data = LightController.all
		@light_controllers = Array.new # a place to store all the status UI elements
		@cookie_urls = []
		if !cookies[:light_controller_urls].nil?
			@cookie_urls = JSON.parse(cookies[:light_controller_urls])
		end
		puts @cookie_urls.count
		puts @cookie_urls
		@data.each do |l|
			urls = @cookie_urls.find { |h| h["id"] == l.id.to_s }
			puts urls
			@light_controllers << {
				id: l.id, 
				name: l.name,
				version: l.version, 
				remote_base_url: l.remote_base_url, 
				total_lights: l.total_lights,
				device_remote_base_url: (urls["remote_base_url"] if !urls.nil?).presence, 
				local_base_url: l.local_base_url, 
				device_local_base_url: (urls["local_base_url"] if !urls.nil?).presence, 
				status: l.parse_status, 
				messages: (JSON.parse(l.status) if !l.status.nil?),
				power_config: (JSON.parse(l.power_config) if !l.power_config.nil?),
				switch_config: (JSON.parse(l.switch_config) if !l.switch_config.nil?)
			}
		end
		@light_controller = LightController.new

		@total_heartbeats = Heartbeat.count(:id)
		@total_bilges = Bilge.count(:id)


	end

	def set_device_id
		cookies.permanent[:device_id] = params[:device_id]
		flash[:success] = "Device registration updated"
		redirect_to action: "index"
	end

	def store_local_config
		cookies.permanent[params[:config]] = params[:value]
		flash[:success] = "#{params[:config]} updated succesfully."
		redirect_to action: "index"
	end

	private

	def validate_device_cookie
		if cookies[:device_id].nil?
			flash[:error] = "Register this device to enable many of the settings on this page."
			@registered = false
		else
			@registered = true
		end
	end

end
