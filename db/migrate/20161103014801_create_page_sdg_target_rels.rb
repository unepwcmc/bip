class CreatePageSdgTargetRels < ActiveRecord::Migration
  def change
    create_table :page_sdg_target_rels do |t|
      t.integer :page_id
      t.references :sdg_target
      t.boolean :official

      t.timestamps
    end
  end
end
