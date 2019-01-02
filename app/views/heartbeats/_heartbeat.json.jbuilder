json.extract! heartbeat, :id, :probe_id, :voltage, :temp, :humid, :created_at, :updated_at
json.url heartbeat_url(heartbeat, format: :json)
