class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :comfy_cms_page
      t.attachment :file
      t.text :label

      t.timestamps
    end
  end
end
