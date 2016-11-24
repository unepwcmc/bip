class CreatePageTagRels < ActiveRecord::Migration
  def change
    create_table :page_tag_rels do |t|
      t.integer :page_id
      t.references :tag

      t.timestamps
    end
  end
end
