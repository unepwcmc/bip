require_dependency Rails.root.join("app/models/concerns/cms_links").to_s
require_dependency Rails.root.join("app/models/concerns/search_integration").to_s

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
