namespace :cms_resource_labels do
  desc 'Updates resource labels to the resource language.'
  task :update => :environment do
    resource_pages = Comfy::Cms::Page.find_by_label("Resources").descendants

    resource_pages.each do |resource_page|
      if resource_page.resources.count == 1
        resource_page.resources.first.update(label: 'English')
      else
        resource_page.resources.each do |resource|
          language = resource.label[/\b(\w+)$/]
          
          resource.update(label: language)
        end
      end
    end
  end

  desc 'Reverts resource labels to parent page label.'
  task :revert => :environment do
    resource_pages = Comfy::Cms::Page.find_by_label("Resources").descendants

    resource_pages.each do |resource_page|
      label = resource_page.label

      if resource_page.resources.count == 1
        resource_page.resources.first.update(label: label)
      else
        resource_page.resources.each do |resource|
          language = resource.label
          
          resource.update(label: "#{label} - #{language}")
        end
      end
    end
  end
end
