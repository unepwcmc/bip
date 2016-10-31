class CreateDisaggregations < ActiveRecord::Migration
  def change
    create_table :disaggregations do |t|
      t.references :comfy_cms_page
      t.text :label
      t.text :url

      t.timestamps
    end
  end
end
