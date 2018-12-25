json.extract! contact, :id, :phone, :name, :bilge_main, :bilge_backup, :charge_error, :created_at, :updated_at
json.url contact_url(contact, format: :json)
