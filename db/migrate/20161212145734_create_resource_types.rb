class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.text :name
    end

    add_reference :resources, :resource_type
  end
end
