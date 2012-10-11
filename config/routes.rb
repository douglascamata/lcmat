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
  get '/cursos' => 'courses#index', as: :courses

  root :to => "site#index"
end

