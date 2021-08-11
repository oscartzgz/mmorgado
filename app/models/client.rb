class Client < ApplicationRecord
  def full_name
    [name, first_surname, second_surname].join(' ')
  end
end
