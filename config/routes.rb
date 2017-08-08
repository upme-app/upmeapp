Rails.application.routes.draw do


  mount Spina::Engine => '/blog'
  root 'visitors#landing_page'


  match '/cursos-superiores', to: 'cursos#all', via: :get
  match '/save_quiz', to: 'visitors#save_quiz', via: :post

end
