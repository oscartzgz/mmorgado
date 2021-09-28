class Client < ApplicationRecord
  include PgSearch::Model
  
  validates_presence_of :name, :first_surname, :second_surname
  
  pg_search_scope :search_scope_full,
                  against: [:name, :first_surname, :second_surname],
                  using: {
                    tsearch: {
                      any_word: true
                    },
                    trigram: {
                      threshold: 0.1
                    }
                  }
  
  def self.search(params)
    clients = self.all.order(name: :asc)
    clients = clients.search_scope_full(params[:full_data]) if params[:full_data]
    clients
  end

  
  def full_name
    [name, first_surname, second_surname].join(' ')
  end

  def full_address
    [address, location, state].join(' ')
  end

  def positive_balance
    "$ 5555.00"
  end
end
