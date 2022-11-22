module ResourcesHelper
  def ordered_resource_links resource_page
    resource_links(resource_page).sort_by do |link|
      link.label == 'English' ? 'AAA' : link.label
    end
  end

  def resource_links resource_page
    resource_page.resources
  end

  def resource_icon_type resource_page
    resource_kind(resource_page) == 'file' ? 'download' : 'external-link'
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

  def result_label result
    result_object(result).label
  end

  def result_link_text
    'View page'
  end

  def result_url result
    result_object(result).full_path
  end

  def result_object result
    result.is_a?(Comfy::Cms::Block) ? result.blockable : result
  end

  def resources_search_placeholder
    params[:q] || 'Search resources by label/name'
  end
end
