# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

post_author1 = User.create!(
  name: "Maria", email: "maria@email.com", password: 123456, password_confirmation: 123456
)
post_author2 = User.create!(
  name: "Joao", email: "joao@email.com", password: 123456, password_confirmation: 123456
)
post_author3 = User.create!(
  name: "Ana", email: "ana@email.com", password: 123456, password_confirmation: 123456
)

post_author1.posts.create!(title: "Post 1", content: "Content 1")
post_author1.posts.create!(title: "Post 2", content: "Content 2")
post_author2.posts.create!(title: "Post 3", content: "Content 3")
post_author2.posts.create!(title: "Post 4", content: "Content 4")
post_author3.posts.create!(title: "Post 5", content: "Content 5")
