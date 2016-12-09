class DropPartnerTypeIdFromPartners < ActiveRecord::Migration
  def up
    Partner.all.select(&:partner_type_id).each do |partner|
      partner.partner_types = [PartnerType.find(partner.partner_type_id)]
    end

    remove_reference :partners, :partner_type
  end

  def down
    add_reference :partners, :partner_type

    Partner.all.each do |partner|
      partner.partner_type = partner.partner_types.first
    end
  end
end
