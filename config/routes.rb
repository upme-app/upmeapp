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

  resources :projects, controller: :projects, path: 'meus-projetos', path_names: { new: 'novo' }
  match 'meus-projetos/:id/linha-do-tempo', as: :timeline, to: 'projects#timeline', via: :get
  match 'meus-projetos/:id/solicitacoes', as: :invitations, to: 'projects#invitations', via: :get
  match 'meus-projetos/:id/enviar-solicitacao', as: :create_invitation, to: 'projects#create_invitation', via: :post
  match 'aceitar-convite/:invitation_id', as: :accept_invitation, to: 'projects_invitation#accept_invitation', via: :get
  match 'recusar-convite/:invitation_id', as: :refuse_invitation, to: 'projects_invitation#refuse_invitation', via: :get
  match 'projetos/:id', to: 'projects#show_public', via: :get

  match 'meu-perfil', to: 'profile#my_profile', via: :get, as: :my_profile
  match 'meu-perfil/editar', to: 'profile#edit_profile', via: :get, as: :edit_profile
  match 'meu-perfil/editar', to: 'profile#save_profile', via: :post, as: :save_profile
  match 'meu-perfil/salvar_foto', to: 'profile#update_picture', via: :post, as: :update_picture

end
