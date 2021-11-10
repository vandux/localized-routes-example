Rails.application.routes.draw do
  scope "(:locale)", locale: Routes.scoped_locales_regex do
    get 'one', to: 'pages#one', as: 'one'
    get 'two', to: 'pages#two', as: 'two'
    get 'three', to: 'pages#three', as: 'three'
    
    root to: 'pages#index'
  end
end
