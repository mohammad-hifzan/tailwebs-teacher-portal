# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# Generate a random name


# Generate a random subject (you can create your own subjects array)
user = User.create(email: 'admin@example.com', password: '123456', username: 'admin')
subjects = ["Math", "Science", "History", "English", "Art"]


# Generate random marks (assuming marks are between 0 and 100)

20.times do |i|
	name = Faker::Name.name.titleize
	subject = subjects.sample.titleize
	marks = rand(0..100)
	Student.create(name: name, subject: subject, mark: marks, user_id: user.id)
end
