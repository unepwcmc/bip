class MeaTarget < ActiveRecord::Base
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  belongs_to :mea
  has_many :page_mea_target_rels, foreign_key: "mea_target_id"
  has_many :pages, through: :page_mea_target_rels
end

