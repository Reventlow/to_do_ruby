# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Check if the admin user already exists to avoid creating duplicates
unless User.exists?(email: "admin@example.com")
  User.create!(
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password",
    admin: true,
    name: "Admin"
  )
end

# Check if the regular user already exists to avoid creating duplicates
unless User.exists?(email: "user@example.com")
  User.create!(
    email: "user@example.com",
    password: "password",
    password_confirmation: "password",
    admin: false,
    name: "User"
  )
end

puts "Seeded admin and user accounts."
