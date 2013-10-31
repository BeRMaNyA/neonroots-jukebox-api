NeonrootsJukeboxApi::Application.routes.draw do
  resources :songs, only: [:create, :index] do
    get :on_sale, on: :collection
  end

  resources :bars, only: [:create] do
    post "/songs" => "bars#buy", on: :member
  end

  root :to => 'bars#index'
end
