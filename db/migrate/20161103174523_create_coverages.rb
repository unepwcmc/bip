class CreateCoverages < ActiveRecord::Migration
  def change
    create_table :coverages do |t|
      t.text :name
    end
  end
end
