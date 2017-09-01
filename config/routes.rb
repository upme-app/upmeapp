Rails.application.routes.draw do

  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  mount Spina::Engine => '/blog'
  root 'visitors#landing_page'


  match '/cursos-superiores', to: 'cursos#all', via: :get
  match '/newsletter', to: 'visitors#post_newsletter', via: :post

  match 'areas-de-interesse', to: 'areas_de_interesse#view', via: :get, as: :areas_de_interesse
  match 'areas-de-interesse', to: 'areas_de_interesse#save', via: :post
  match 'areas-de-interesse/nomes', to: 'areas_de_interesse#all_names', via: :get
  match 'areas-de-interesse/minhas-areas', to: 'areas_de_interesse#minhas_areas', via: :get

  match 'explorar', to: 'explore#index', as: :explore, via: :get

  get 'meus-projetos', to: 'meus_projetos#index', via: :get, as: :meus_projetos
  get 'meus-projetos/novo', to: 'meus_projetos#new', via: :get, as: :novo_projeto
  get 'meus-projetos/:id', to: 'meus_projetos#show', via: :get, as: :ver_projeto

end
