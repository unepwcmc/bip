class Tag < ActiveRecord::Base
  has_many :page_tag_rels
  has_many :pages, through: :page_tag_rels
end
