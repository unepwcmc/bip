class CreatePagePartnerRels < ActiveRecord::Migration
  def change
    create_table :page_partner_rels do |t|
      t.integer :page_id
      t.references :partner

      t.timestamps
    end
  end
end
