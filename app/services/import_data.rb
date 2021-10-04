require 'roo'

class ImportData
  attr_reader :file, :subject, :imported_data, :errors

  PROVIDER_ATTRIBS = {
    'Código':     :code,
    'Nombre':     :full_name,
    'Tipo':       :kind,
    'Num Fijo':   :phone_number,
    'Dirección':  :address,
    'Ciudad':     :city,
    'País':       :country,
    'Código Postal': :postal_code,
    'Nombre Contacto': :contact_full_name,
    'Correo Contacto': :contact_email,
    'Num Fijo Contacto': :contact_phone_number,
    'Num Móvil Contacto': :contact_mobile_number
  }


  def initialize(file = nil, subject)
    @file = file
    @subject = subject
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

  def subject_attributes(header)
    if subject == Provider
      header.map { |e| PROVIDER_ATTRIBS[e.to_sym] }
    else raise "Subject not defined => #{subject.to_s}"
    end
  end

end