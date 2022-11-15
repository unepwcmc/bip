module ResourcesHelper
  def ordered_resource_links resource_page
    resource_links(resource_page).sort_by do |link|
      link.label == 'English' ? 'AAA' : link.label
    end
  end

  def resource_links resource_page
    resource_page.resources
  end

  def resource_icon_class resource_page
    resource_kind(resource_page) == 'file' ? 'fa-download' : 'fa-link'
  end

  def resource_link_text resource_page
    resource_kind(resource_page) == 'file' ? 'Download' : 'View'
  end

  def resource_kind resource_page
    resource_page.resources.first.kind
  end

  def resource_url resource
    resource.kind == 'file' ? resource.file.url : resource.url
  end
end
