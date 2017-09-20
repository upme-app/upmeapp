Rails.application.routes.draw do

  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'entrar', to: 'devise/sessions#new', as: :entrar
    get 'registrar', to: 'devise/registrations#new', as: :registrar
    get 'minha-conta', to: 'devise/registrations#edit', as: :my_account
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
  match 'meus-projetos-arquivados', as: :filed_projects, to: 'projects#filed_projects', via: :get
  match 'meus-projetos/:id/excluir', as: :delete_project, to: 'projects#delete', via: :get
  match 'meus-projetos/:id/duplicar', as: :duplicate_project, to: 'projects#duplicate', via: :get
  match 'meus-projetos/:id/restaurar', as: :restore_project, to: 'projects#restore', via: :get
  match 'meus-projetos/:id/linha-do-tempo', as: :timeline, to: 'projects#timeline', via: :get
  match 'meus-projetos/:id/solicitacoes-de-clientes', as: :client_solicitations, to: 'projects#client_solicitations', via: :get
  match 'meus-projetos/:id/solicitacoes-de-membros', as: :member_solicitations, to: 'projects#member_solicitations', via: :get
  match 'meus-projetos/:id/enviar-solicitacao-para-usuario', as: :invite_user_to_project, to: 'projects#invite_user_to_project', via: :post
  match 'aceitar-convite/:invitation_id', as: :accept_invitation, to: 'projects_invitation#accept_invitation', via: :get
  match 'recusar-convite/:invitation_id', as: :refuse_invitation, to: 'projects_invitation#refuse_invitation', via: :get

  match 'meus-projetos/:id/linha-do-tempo/comentar', as: :timeline_comment, to: 'projects#timeline_comment', via: :post

  match 'aceitar-solicitacao-cliente/:solicitation_id', as: :accept_client_solicitation, to: 'client_solicitation#accept', via: :get
  match 'recusar-solicitacao-cliente/:solicitation_id', as: :refuse_client_solicitation, to: 'client_solicitation#refuse', via: :get

  match 'aceitar-solicitacao-membro/:solicitation_id', as: :accept_member_solicitation, to: 'member_solicitation#accept', via: :get
  match 'recusar-solicitacao-membro/:solicitation_id', as: :refuse_member_solicitation, to: 'member_solicitation#refuse', via: :get

  # PUBLIC PROJECTS
  match 'projetos/:id', to: 'projects#show_public', via: :get, as: :public_project
  match 'projetos/:id/enviar-solicitacao-cliente', to: 'projects#add_client_solicitation', via: :post, as: :add_client_solicitation
  match 'projetos/:id/enviar-solicitacao-membro', to: 'projects#add_member_solicitation', via: :post, as: :add_member_solicitation

  match 'meu-perfil', to: 'profile#my_profile', via: :get, as: :my_profile
  match 'meu-perfil/editar', to: 'profile#edit_profile', via: :get, as: :edit_profile
  match 'meu-perfil/editar', to: 'profile#save_profile', via: :post, as: :save_profile
  match 'meu-perfil/salvar_foto', to: 'profile#update_picture', via: :post, as: :update_picture
  match 'meu-perfil/salvar_logo', to: 'profile#update_logo', via: :post, as: :update_logo
  match 'perfil/:id', to: 'profile#profile', via: :get, as: :profile


end
