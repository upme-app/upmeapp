# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if Rails.env.development?
  User.create({
      first_name: 'aluno',
      last_name: 'sobrenome',
      email: 'aluno@test.com',
      password: '123456',
      user_type: :aluno
  })

  User.create({
      first_name: 'professor',
      last_name: 'sobrenome',
      email: 'professor@test.com',
      password: '123456',
      user_type: :professor
  })

  User.create({
      first_name: 'empresa',
      last_name: 'sobrenome',
      email: 'empresa@test.com',
      password: '123456',
      user_type: :empresa
  })
end
