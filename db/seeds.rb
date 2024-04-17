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

20.times do |i|
  post_author1.posts.create!(
    title: "Publicação #{i + 1}", content: "Esse é o conteúdo incrível da minha publicação #{i + 1}"
  )
end

20.times do |i|
  post_author2.posts.create!(
    title: "Publicação #{i + 1}", content: "Esse é o conteúdo incrível da minha publicação #{i + 1}"
  )
end