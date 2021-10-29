# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
admin = User.create_with(username: 'admin', password: "Morgado12$", role: :admin).find_or_create_by(email: "admin@mmorgado.com")
admin.create_profile

ProductCategory.destroy_all
['Línea Blanca', 'Muebles'].each do |category|
  ProductCategory.create name: category
end