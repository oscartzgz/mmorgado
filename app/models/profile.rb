class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end
end
