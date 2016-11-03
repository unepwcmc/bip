class CreatePageMeaTargetRels < ActiveRecord::Migration
  def change
    create_table :page_mea_target_rels do |t|
      t.integer :page_id
      t.references :mea_target
      t.boolean :official

      t.timestamps
    end
  end
end
