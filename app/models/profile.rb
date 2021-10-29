class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize: "100x100"
  end

  def full_name
    return user.username if name.blank?
    [name, first_surname, second_surname].join(' ')
  end
end
