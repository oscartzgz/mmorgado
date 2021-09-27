class Client < ApplicationRecord
  validates_presence_of :name, :first_surname, :second_surname
  
  def full_name
    [name, first_surname, second_surname].join(' ')
  end

  def full_address
    [address, location, state].join(' ')
  end
end
