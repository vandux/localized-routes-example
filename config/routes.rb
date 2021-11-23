Rails.application.routes.draw do
  scope "(:locale)", locale: Routes.scoped_locales_regex do
    scope 'pages' do
      get 'one', to: 'pages#one', as: 'one'
      get 'two', to: 'pages#two', as: 'two'
      get 'three', to: 'pages#three', as: 'three'
    end
    
    root to: 'pages#index'
  end
end
