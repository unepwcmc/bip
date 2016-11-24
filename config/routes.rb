Rails.application.routes.draw do
  namespace :admin do
    resources :partners, except: [:show]
    resources :themes, except: [:show]
    resources :meas, except: [:show] do
      member do
        delete "delete_target"
      end
    end
    resources :aichi_targets, except: [:show]
    resources :aichi_goals, except: [:show]
    resources :sdg_targets, except: [:show]
    resources :sdg_goals, except: [:show]
    resources :resources, only: [:destroy]
    resources :disaggregations, only: [:destroy]
  end

  get "/search" => "search#search"
  get "/resources" => "resources#index"

  comfy_route :cms_admin, :path => '/admin'

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false
end
