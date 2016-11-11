class CreatePartnerTypes < ActiveRecord::Migration
  def change
    create_table :partner_types do |t|
      t.text :name
    end

    add_reference :partners, :partner_type
  end
end
