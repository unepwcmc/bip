class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.text :name
      t.text :description
      t.attachment :logo
    end
  end
end
