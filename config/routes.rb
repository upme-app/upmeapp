Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'visitors#landing_page'


  match '/cursos-superiores', to: 'cursos#all', via: :get
  match '/save_quiz', to: 'visitors#save_quiz', via: :post

end
