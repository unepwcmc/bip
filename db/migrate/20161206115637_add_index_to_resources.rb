class AddIndexToResources < ActiveRecord::Migration
  def change
    add_column :resources, :index, :integer

    Resource.all.group_by(&:comfy_cms_page_id).each do |group|
      group.last.each_with_index do |resource, i|
        resource.index = i+1
        resource.save
      end
    end
  end
end
