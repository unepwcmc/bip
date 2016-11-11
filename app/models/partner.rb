class Partner < ActiveRecord::Base
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  belongs_to :partner_type
  has_many :page_partner_rels
  has_many :pages, through: :page_partner_rels
end

