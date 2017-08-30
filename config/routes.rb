Rails.application.routes.draw do


  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }

  mount Spina::Engine => '/blog'
  root 'visitors#landing_page'


  match '/cursos-superiores', to: 'cursos#all', via: :get
  match '/newsletter', to: 'visitors#post_newsletter', via: :post

end
