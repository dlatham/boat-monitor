class LightController < ApplicationRecord
	def parse_status
		# Return a parsed version of the status JSONB for use in the UI
		error_count = 0
		warning_count = 0
		info_count = 0
		new_device = false
		if !self.status.nil?
			data = JSON.parse(self.status)
			data.each do |status|
				case status["status"]
					when "error"
						error_count += 1
					when "warning"
						warning_count += 1
					when "info"
						info_count += 1
					when "new"
						new_device = true
				end
			end
		end
		if error_count > 0
			parsed = { id: self.id, indicator: "status-error", message: pluralize(error_count, "error") }
		elsif warning_count > 0
			parsed = { id: self.id, indicator: "status-warning", message: pluralize(warning_count, "warning") }
		elsif info_count > 0
			parsed = { id: self.id, indicator: "status-info", message: pluralize(info_count, "item") }
		elsif new_device
			parsed = { id: self.id, indicator: "status-info", message: "New" }
		else
			parsed = { id: self.id, indicator: "status-success", message: "Ok" }
		end
		return parsed
	end

	def get_status
		# Call the light controller and have it return it's current status

	end

	private

	
end
