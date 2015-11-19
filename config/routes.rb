#coding=utf-8
Rails.application.routes.draw do

  get 'dashboard/index'

  match 'zhang/dashboard', to: 'administer/dashboard#index',via: :get, as: :dashboard
  match 'zhang/columns', to: 'administer/columns#index',via: :get, as: :columns
  match 'zhang/sign_in', to: 'administer/sessions#admin_sign_in',via: :get, as: :admin_sign_in
  match 'zhang/sign_out', to: 'administer/sessions#admin_sign_out',via: :get, as: :admin_sign_out
  post 'zhang/admin_login', to: 'administer/sessions#admin_sign_login', as: :admin_login
  match 'zhang' => redirect('/zhang/dashboard'), via: :get
  namespace :administer, path:'/zhang' do
    resources :columns
  end

  devise_for :users, controllers:{
       sessions: 'users/sessions',
       registrations: 'users/registrations',
       passwords: 'users/passwords'
   }
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_out', to: 'users/sessions#destroy'
    get 'pass_forgot', to: 'users/passwords#new'
    post 'sign_login', to: 'users/sessions#create'
  end
  root 'welcome#index'

end
