class RemakeDisaggregations < ActiveRecord::Migration
  def change
    drop_table :disaggregations do |t|
      t.references :comfy_cms_page
      t.text :label
      t.text :url

      t.timestamps
    end

    create_table :disaggregations do |t|
      t.integer :parent_id
      t.integer :target_id

      t.timestamps
    end

    add_index :disaggregations, :parent_id
  end
end
