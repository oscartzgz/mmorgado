class ProviderContact < ApplicationRecord
  belongs_to :provider

  validates :full_name, presence: true

  scope :primary, -> { where(primary_contact: true ) }
end
