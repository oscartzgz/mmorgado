require 'roo'

class ImportData
  attr_reader :file, :subject, :imported_data, :errors

  PROVIDER_ATTRIBS = {
    codigo:             :code,
    nombre:             :full_name,
    tipo:               :kind,
    num_fijo:           :phone_number,
    direccion:          :address,
    ciudad:             :city,
    pais:               :country,
    codigo_postal:      :postal_code,
    nombre_contacto:    :contact_full_name,
    correo_contacto:    :contact_email,
    num_fijo_contacto:  :contact_phone_number,
    num_movil_contacto: :contact_mobile_number
  }

  CLIENT_ATTRIBS = {
    codigo:                   :code,
    nombre:               :name,
    apellido_paterno:     :first_surname,
    apellido_materno:     :second_surname,
    saldo_favor:          :positive_balance,
    direccion:            :address,
    ciudad:               :location,
    estado:               :state,
    pais:                 :country,
    codigo_postal:        :postal_code,
    correo:               :email,
    num_fijo:             :phone_number,
    num_movil:            :mobile_number,
    aval_nombre_completo: :endorsement_full_name,
    aval_num_movil:       :endorsement_mobile_phone,
    aval_num_fijo:        :endorsement_phone_number,
    aval_direccion:       :endorsement_address,
    aval_ciudad:          :endorsement_location,
    aval_pais:            :endorsement_country,
    aval_codigo_postal:   :endorsement_postal_code,
    aval_parentesco:      :endorsement_relationship
  }

  PRODUCT_ATTRIBS = {
    codigo: :code,
    producto: :name,
    modelo: :model,
    descripcion: :description,
    stock: :stock,
    stock_minimo: :min_stock,
    precio_lista: :list_price,
    precio_credito: :credit_price,
    precio_costo: :cost_price,
    # precio_pp: :pp_price,
    # precio_cash: :cash_price,
    proveedor: :provider_id, ## Get by name? get by code?
    marca: :product_brand_id, ## Get by name? get by code?
    linea: :product_category_id, ## Get by name? get by code?
  }


  def initialize(file = nil, subject)
    @file = file
    @subject = subject
  end

  def save
    if imported_data.map(&:valid?).all?
      imported_data.each(&:save!)
      true
    else
      @errors = []
      imported_data.each_with_index do |item, index|
        item.errors.full_messages.each do |msg|
          errors << "FILA #{index + 4}: #{msg}"
        end
      end
      false
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when '.csv' then Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_data
    spreadsheet = open_spreadsheet
    header = subject_attributes(spreadsheet.row(3))
    (4..spreadsheet.last_row).map do |i|
      attributes = Hash[[header, spreadsheet.row(i)].transpose]
      item = subject.find_by_code(attributes[:code].to_s) || subject.new
      item.attributes = attributes
      item
    end
  end

  def imported_data
    @imported_data ||= load_imported_data
  end

  def subject_attributes(header)
    if subject == Provider
      header.map { |e| PROVIDER_ATTRIBS[e.parameterize(separator: '_').to_sym] }
    elsif subject == Client
      header.map { |e| CLIENT_ATTRIBS[e.parameterize(separator: '_').to_sym] }
    else raise "Subject not defined => #{subject.to_s}"
    end
  end

end