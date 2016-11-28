class Initiative < ActiveRecord::Base
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  belongs_to :page, class_name: "Comfy::Cms::Page", foreign_key: "comfy_cms_page_id"
end
