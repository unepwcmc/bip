class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.text :name
      t.attachment :logo
      t.text :url

      t.timestamps
    end
  end
end
