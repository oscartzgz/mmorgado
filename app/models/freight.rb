class Freight < ApplicationRecord
  include PgSearch::Model

  belongs_to :client
  belongs_to :order
  belongs_to :user

  pg_search_scope :search_scope_full,
                  associated_against: {
                    order: :code,
                    user: [:name, :first_surname, :second_surname]
                  },
                  against: [:id],
                  using: {
                    tsearch: {
                      any_word: true
                    },
                    trigram: {
                      threshold: 0.1
                    }
                  }
end
