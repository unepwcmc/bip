class CreateIndicatorClassifications < ActiveRecord::Migration
  def change
    create_table :indicator_classifications do |t|
      t.text :name
    end
  end
end
