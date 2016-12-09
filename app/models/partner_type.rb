class PartnerType < ActiveRecord::Base
  has_many :partner_partner_type_rels
  has_many :partners, through: :partner_partner_type_rels
end
