class ClientSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :full_address, :positive_balance

  def full_name
    object.full_name
  end

  def full_address
    object.full_address
  end

  def positive_balance
    object.positive_balance
  end
end
