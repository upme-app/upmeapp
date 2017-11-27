namespace :db do

  desc "Setup Development"
  task setup: :environment do

    puts "Executando o setup para ambiente de  #{Rails.env}"

    puts "Apagando o BD...#{%x(rails db:drop)}"
    puts "Criando o BD...#{%x(rails db:create)}"
    puts %x(rails db:migrate)
    puts %x(rails db:generate_itens)


    puts "Setup completado"
  end


  desc "criando Usuários"
  task generate_itens: :environment do
    puts "Cadastrando Usuários..."
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
    puts "Usuários de exemplo cadastrados..."
  end



  desc "criando eventos teste"
  task generate_itens: :environment do
    puts "Cadastrando eventos de teste..."
    ProjectEvent.create({
                    title: 'Evento um',
                    description: 'Evento teste um',
                    project_id: 1,
                    user_id: 1,
                    start_date: DateTime.now,
                    end_date: DateTime.now
                })
    puts "Eventos de exemplo cadastrados..."
  end


end