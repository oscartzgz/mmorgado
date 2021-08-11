json.extract! provider, :id, :full_name, :phone_number, :address, :city, :country, :postal_code, :contact_full_name, :contact_email, :contact_phone_number, :contact_mobile_number, :created_at, :updated_at
json.url provider_url(provider, format: :json)
