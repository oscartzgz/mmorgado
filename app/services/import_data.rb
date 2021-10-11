require 'roo'

class ImportData
  attr_reader :file, :subject, :imported_data, :errors

  EXCEL_HEADER_ROW = 3

  PROVIDER_ATTRIBS = {
    codigo:             :code,
    nombre:             :full_name,
    tipo:               :kind,
    correo:             :email,
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
    codigo:               :code,
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
    precio_pp: :pp_price,
    precio_cash: :cash_price,
    proveedor: :provider_id,
    marca: :product_brand_id,
    linea: :product_category_id,
  }


  def initialize(file = nil, subject)
    @file = file
    @subject = subject
    @errors = []
    @final_attributes = []
  end

  def save
    if imported_data.map(&:valid?).all?
      subject.upsert_all(@final_attributes)
      create_brands!
      true
    else
      imported_data.each_with_index do |item, index|
        item.errors.full_messages.each do |msg|
          errors << "FILA #{index + EXCEL_HEADER_ROW + 1}: #{msg}"
        end
      end
      false
    end
  # rescue NoMethodError
  #   byebug
  #   false
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
    header = subject_attributes(spreadsheet.row(EXCEL_HEADER_ROW))

    ((EXCEL_HEADER_ROW + 1)..spreadsheet.last_row).map do |i|
      attributes = Hash[[header, spreadsheet.row(i)].transpose]
      attributes = set_relationships_for(subject, attributes)
      item = subject.find_by_code(attributes[:code].to_s) || subject.new
      item.attributes = attributes
      attributes[:id] = item.id if item.persisted?
      @final_attributes << attributes
      item
    end
  rescue ActiveModel::UnknownAttributeError
    errors << "CABECERA DE TABLA: Las columnas aceptadas son: #{
               PROVIDER_ATTRIBS.keys.map{ |e| "\"#{e.to_s.split('_').join(' ').camelize}\"" }.join(', ') }.
               Columnas con mas de una palabra deben respetar los espacios entre palabras. 
               El orden es irrelevante asi como tambien minusculas/mayusculas."
  end

  def imported_data
    @imported_data ||= load_imported_data
  end

  def subject_attributes(header)
    if subject == Provider
      header.map { |e| PROVIDER_ATTRIBS[e.parameterize(separator: '_').to_sym] }
    elsif subject == Client
      header.map { |e| CLIENT_ATTRIBS[e.parameterize(separator: '_').to_sym] }
    elsif subject == Product
      header.map { |e| PRODUCT_ATTRIBS[e.parameterize(separator: '_').to_sym] }
    else raise "Subject not defined => #{subject.to_s}"
    end
  end

  private 

  def set_relationships_for(subject, attributes)
    if subject == Provider && attributes[:kind].downcase == 'fabricante'
      brands_to_create << attributes[:full_name] unless brands_map.dig(attributes[:full_name].downcase)
    elsif subject == Product
      attributes[:provider_id] = Provider.where('lower(full_name) = ?', attributes[:provider_id].downcase).first&.id
      attributes[:product_brand_id] = brands_map.dig(attributes[:product_brand_id].downcase)
      attributes[:product_category_id] = product_categories_map.dig(attributes[:product_category_id].downcase)
    end
    attributes
  end

  def create_brands!
    brands_to_create.each do |name|
      ProductBrand.create!(name: name) 
    end
  end

  def brands_map
    @brands_name_dictionary ||= ProductBrand.all.map{ |e| [e.name.downcase, e.id]}.to_h
  end

  def product_categories_map
    @product_categories_dictionary ||= ProductCategory.all.map{ |e| [e.name.downcase, e.id]}.to_h
  end

  def brands_to_create
    @brands_to_create ||= []
  end
end