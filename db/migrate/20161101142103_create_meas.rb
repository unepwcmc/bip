class CreateMeas < ActiveRecord::Migration
  def change
    create_table :meas do |t|
      t.text :name
      t.text :description

      t.attachment :logo

      t.timestamps
    end
  end
end
