  # -*- encoding : utf-8 -*-

Lcmat::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

#= 1. user routes ==============================================================
  devise_for :users

#= 2. contact routes ===========================================================
  get "/contact" => "site#contact", as: :contact
  post "/contact" => "site#send_contact", as: :send_contact

#= 3. courses routes ===========================================================
  get '/cursos/:id' => 'courses#show', as: 'course'

#= 4. informatives routes ======================================================
  get '/informativos' => 'informatives#index', as: :informatives
  get '/informativo/:id' => 'informatives#show', as: :informative

#= 5. courses routes ===========================================================
  get '/professores/:id' => 'professors#show', as: 'professor'


  root :to => "site#index"
end

