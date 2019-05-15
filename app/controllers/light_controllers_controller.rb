class LightControllersController < ApplicationController

	def create
		@light_controller = LightController.new(light_controller_params)
		begin
			@light_controller.save!
		rescue ActiveRecord::RecordNotUnique => invalid
  			flash[:error] = "Light controller name already taken."
  		else
			flash[:success] = "New light controller created."
		ensure
			redirect_to controller: "settings", action: "index"
		end
	end

	def update
		#must be able to respond to one off updates from the config controller as well
		if !params[:update_type].nil?
			case params[:update_type]
			when "base_url"
				#TODO handle the SSL flag and storage
				if params[:device] == "true"
					response = update_device_urls(params[:id], params[:base], params[:url], params[:ssl])
				else
					response = update_server_urls(params[:id], params[:base], params[:url], params[:ssl])
				end
			when "power_config"
				@light_controller = LightController.find(params[:id])
				#data = JSON.parse(params[:switch_config])
				@light_controller.power_config = params[:power_config].to_json
				@light_controller.save!
			when "switch_config"
				@light_controller = LightController.find(params[:id])
				data = JSON.parse(params[:switch_config])
				@light_controller.switch_config = data.to_json
				@light_controller.save!
			end
		end

		render status: 200, body: response


	end

	def get_controller_config
		# Generally called from AJAX to get the json that powers the lighting UI
		@light_controller = LightController.find(params[:light_controller_id])
		if @light_controller
			render :json => @light_controller.power_config
		end
	end

	private

	def light_controller_params
      params.require(:light_controller).permit(:name, :slug, :total_lights, :local_base_url, :remote_base_url, :username, :password, :status)
    end

    def update_device_urls(id, base, url, ssl)
    	# Update or store the cookie for a local device base_url
    	url_selector = base + "_base_url"
    	ssl_selector = base + "_ssl"
    	cookie_data = []
    	if !cookies[:light_controller_urls].nil?
    		cookie_data = JSON.parse(cookies[:light_controller_urls])
    	end
    	data = cookie_data.find { |h| h["id"] == id }
    	if !data.nil?
    		data[url_selector] = url
    		data[ssl_selector] = ssl
    	else
    		cookie_data << { id: id, url_selector => url, ssl_selector => ssl }
    	end
    	cookies.permanent[:light_controller_urls] = JSON.generate(cookie_data)
    	return { status: "success", message: "Updates base_urls successfully" }
    end

    def update_server_urls(id, base, url, ssl)
    	@light_controller = LightController.find(params[:id])
		if params[:base] == "local"
			@light_controller.local_base_url = params[:url]
		elsif params[:base] == "remote"
			@light_controller.remote_base_url = params[:url]
		else
			Rails.logger.error "LIGHT_CONTROLLERS wrong update base [#{params[:base]}] provided."
		end
	end
end
