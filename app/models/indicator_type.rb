class IndicatorType < ActiveRecord::Base
  has_many :pages, class_name: "Comfy::Cms::Page"
end
