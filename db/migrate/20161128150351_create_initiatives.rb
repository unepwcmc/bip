class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.text :scale
      t.text :year_started
      t.text :countries_included
      t.text :organization_responsible
      t.text :focal_point

      t.text :number_of_indicators
      t.text :framework

      t.references :comfy_cms_page

      t.attachment :logo
      t.timestamps
    end
  end
end
