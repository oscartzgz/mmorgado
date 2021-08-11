class Client < ApplicationRecord
  def full_name
    [name, first_surname, second_surname].join(' ')
  end

  def full_address
    [address, location, state].join(' ')
  end
end
