# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(username: 'admin', password: 'password', password_confirmation: 'password', email: 'admin@gmail.com', admin: true)
User.create!(username: 'test_user', password: 'password', password_confirmation: 'password', email: 'test@gmail.com', admin: false)

Category.create!(category: 'Ruby on Rails')
Category.create!(category: 'JavaScript')
Category.create!(category: 'HTML/CSS')
Category.create!(category: 'IT')
Category.create!(category: 'TDD')
Category.create!(category: 'Git')
Category.create!(category: 'SQL')
