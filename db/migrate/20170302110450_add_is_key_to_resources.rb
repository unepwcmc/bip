class AddIsKeyToResources < ActiveRecord::Migration
  def change
    add_column :resources, :is_key, :boolean, default: false
  end
end
