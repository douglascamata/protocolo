Protocolo::Application.routes.draw do

  devise_for :users

  root to: 'home#index'

  resources :processos, only: [:new, :create, :show] do
    collection do
      get :receber
      get :aguardando_recebimento
      get :aguardando_reabrimento
      get :encerrar
      get :buscar
      get :reabrir
    end
    member do
      put :receber
      put :encerrar
      put :reabrir
    end
  end

  resources :tramitacoes, only: [:new, :create, :show] do
    get :atualizar_processos, :on => :collection
  end

  resources :despachos, only: [:new, :create, :show]

  resources :juntadas, only: [:new, :create, :show] do
    collection do
      get :buscar
      get :atualizar_processos
      get :desapensar
      get :desanexar
    end
    member do
      put :desanexar_processo
    end
  end

  resources :solicitantes, only: [:new, :create, :show]

  resources :setores, only: [:new, :create, :show]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

