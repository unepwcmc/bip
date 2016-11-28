class Initiative < ActiveRecord::Base
  belongs_to :page, class_name: "Comfy::Cms::Page", foreign_key: "comfy_cms_page_id"
end
