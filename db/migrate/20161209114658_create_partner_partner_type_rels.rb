class CreatePartnerPartnerTypeRels < ActiveRecord::Migration
  def change
    create_table :partner_partner_type_rels do |t|
      t.references :partner
      t.references :partner_type
    end
  end
end
