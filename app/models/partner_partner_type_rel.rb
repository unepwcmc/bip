class PartnerPartnerTypeRel < ActiveRecord::Base
  belongs_to :partner
  belongs_to :partner_type
end
