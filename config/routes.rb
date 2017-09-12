Rails.application.routes.draw do

  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'entrar', to: 'devise/sessions#new', as: :entrar
    get 'registrar', to: 'devise/registrations#new', as: :registrar
  end

  mount Spina::Engine => '/blog'
  root 'visitors#landing_page'


  match '/cursos-superiores', to: 'cursos#all', via: :get
  match '/newsletter', to: 'visitors#post_newsletter', via: :post

  match 'areas-de-interesse', to: 'areas_de_interesse#view', via: :get, as: :areas_de_interesse
  match 'areas-de-interesse', to: 'areas_de_interesse#save', via: :post
  match 'areas-de-interesse/nomes', to: 'areas_de_interesse#all_names', via: :get
  match 'areas-de-interesse/minhas-areas', to: 'areas_de_interesse#minhas_areas', via: :get

  match 'explorar', to: 'explore#index', as: :explore, via: :get


  # PROJECTS
  resources :projects, controller: :projects, path: 'meus-projetos', path_names: { new: 'novo' }
  match 'meus-projetos/:id/linha-do-tempo', as: :timeline, to: 'projects#timeline', via: :get
  match 'meus-projetos/:id/solicitacoes', as: :invitations, to: 'projects#invitations', via: :get
  match 'meus-projetos/:id/enviar-solicitacao', as: :create_invitation, to: 'projects#create_invitation', via: :post
  match 'aceitar-convite/:invitation_id', as: :accept_invitation, to: 'projects_invitation#accept_invitation', via: :get
  match 'recusar-convite/:invitation_id', as: :refuse_invitation, to: 'projects_invitation#refuse_invitation', via: :get

  match 'aceitar-solicitacao-cliente/:solicitation_id', as: :accept_client_solicitation, to: 'project_client_solicitation#accept_client_solicitation', via: :get
  match 'recusar-solicitacao-cliente/:solicitation_id', as: :refuse_client_solicitation, to: 'project_client_solicitation#refuse_client_solicitation', via: :get


  # PUBLIC PROJECTS
  match 'projetos/:id', to: 'projects#show_public', via: :get, as: :public_project
  match 'projetos/:id/enviar-solicitacao', to: 'projects#add_client_solicitation', via: :post, as: :add_client_solicitation

  match 'meu-perfil', to: 'profile#my_profile', via: :get, as: :my_profile
  match 'meu-perfil/editar', to: 'profile#edit_profile', via: :get, as: :edit_profile
  match 'meu-perfil/editar', to: 'profile#save_profile', via: :post, as: :save_profile
  match 'meu-perfil/salvar_foto', to: 'profile#update_picture', via: :post, as: :update_picture

end
