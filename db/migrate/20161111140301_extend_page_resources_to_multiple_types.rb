class ExtendPageResourcesToMultipleTypes < ActiveRecord::Migration
  def change
    add_column :resources, :kind, :text
    add_column :resources, :url, :text
  end
end
