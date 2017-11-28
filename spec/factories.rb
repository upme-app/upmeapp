FactoryGirl.define do
  factory :invite_person do
    user nil
    to_email "MyString"
    token "MyString"
    project nil
    completed false
  end

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

  factory :professor, class: User do
    first_name 'joao prof'
    last_name 'silva prof'
    email { generate(:email) }
    password '123456'
    user_type :professor
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
