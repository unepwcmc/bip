class PagePartnerRel < ActiveRecord::Base
  belongs_to :page, class_name: "Comfy::Cms::Page"
  belongs_to :partner
end
