Rails.application.routes.draw do
  namespace :admin do
    resources :partners, except: [:show]
    resources :themes, except: [:show]
    resources :tags, except: [:show]
    resources :meas, except: [:show] do
      member do
        delete "delete_target"
      end
    end
    resources :sdg_targets, except: [:show]
    resources :sdg_goals, except: [:show]
    resources :resources, only: [:destroy] do
      collection do
        get "resource_form"
      end
    end
    resources :disaggregations, only: [:destroy]
  end

  get "/search" => "search#search"
  get "/resources" => "resources#index"
  get "/partners" => "partners#index"
  get "/download" => "downloads#show", as: :download
  get "/biodiversity-indicators" => "biodiversity_indicators#index"

  CSV.foreach(Rails.root.join("lib/data/redirects.csv").to_s, headers: true) do |row|
    get row["original"] => redirect(row["new"])
  end

  comfy_route :cms_admin, :path => '/admin'

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false
end
