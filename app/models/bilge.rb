class Bilge < ApplicationRecord
	def notify_contacts!
		if self.pump_no == 1
			@contacts = Contact.where(bilge_main: true)
		elsif self.pump_no == 2
			@contacts = Contact.where(bilge_backup: true)
		end
		@contacts.each do |contact|
			TwilioTextMessenger.new("Bilge pump updated.", contact.phone).call
		end
	end
end
