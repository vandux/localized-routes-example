Rails.application.routes.draw do
  scope "(:locale)", locale: Routes.scoped_locales_regex do
    get 'test', to: 'pages#test', as: 'test'
    
    root to: 'pages#index'
  end
end
