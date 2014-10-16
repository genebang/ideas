Ideas::Application.routes.draw do

  devise_for :users, path_names: { sign_in: "login", sign_out: "logout" },
                     controllers: { omniauth_callbacks: "omniauth_callbacks"}

  resources :ideas do
    resources :comments
    resources :attachments
    collection { post :import }
  end

  match 'archived', to: "ideas#archived", as: "archived"
  match 'savefile', to: "ideas#savefile", as: "savefile"  
  match 'import_form', to: "ideas#import_form", as: "import_form"  

  post "/ideas/:idea_id/votes/up" => "votes#up", as: "vote_up"
  post "/ideas/:idea_id/votes/down" => "votes#down", as: "vote_down"

  post "/ideas/:id/archive" => "ideas#archive", as: "archive"
  
  root to: "ideas#index"

end
