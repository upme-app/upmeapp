FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :student, class: User do
    first_name 'joao'
    last_name 'silva'
    email { generate(:email) }
    password '123456'
    user_type :aluno
  end

  factory :client, class: User do
    first_name 'maria'
    last_name 'lima'
    email { generate(:email) }
    password '123456'
    user_type :empresa
  end

  factory :project do
    title 'a title'
  end

end