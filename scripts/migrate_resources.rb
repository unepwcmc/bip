resource_pages = Comfy::Cms::Page.find_by_label("Resources").descendants

puts "#{resource_pages.count} resource pages found"

puts "Updating resource labels..."

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