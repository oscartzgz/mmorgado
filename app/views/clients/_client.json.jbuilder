json.extract! client, :id, :name, :first_surname, :second_surname, :address, :location, :state, :country, :postal_code, :email, :mobile_number, :phone_number, :endorsement_full_name, :endorsement_mobile_phone, :endorsement_phone_number, :endorsement_address, :endorsement_location, :endorsement_country, :endorsement_postal_code, :endorsement_relationship, :created_at, :updated_at
json.url client_url(client, format: :json)
