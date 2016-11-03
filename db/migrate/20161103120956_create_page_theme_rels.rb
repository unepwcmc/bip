class CreatePageThemeRels < ActiveRecord::Migration
  def change
    create_table :page_theme_rels do |t|
      t.integer :page_id
      t.references :theme
    end
  end
end
