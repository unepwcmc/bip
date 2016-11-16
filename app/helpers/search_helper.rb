module SearchHelper
  def search_result result, query
    if result.is_a?(Comfy::Cms::Block)
      doc = Nokogiri::HTML(result.content)

      translation = "translate(., '#{query.upcase}', '#{query.downcase}')"
      text = doc.xpath("//p[contains(#{translation}, '#{query}')]").first.to_s

      regex = Regexp.new("(#{params[:q]})", true)
      raw(text.gsub(regex, '<strong>\1</strong>'))
    else
      doc = Nokogiri::HTML(result.content_cache)
      text = doc.xpath("//p[contains(text(), ' ')]").first.to_s
      raw(text)
    end
  end

  def filter_link type, id
    id = id.to_s
    new_params = params.dup
    new_filters = (params[:filters] || {}).dup

    if new_filters.has_key?(type) && new_filters[type].delete(id)
      url_for(new_params.merge(filters: new_filters))
    else
      new_filters[type] ||= []
      new_filters[type] << id
      url_for(new_params.merge(filters: new_filters))
    end
  end

  def bucket_item_toggle_class type, id
    if params[:filters]&.has_key?(type) && params[:filters][type].include?(id.to_s)
      "filters__bucket-item-toggle is-selected"
    else
      "filters__bucket-item-toggle"
    end
  end
end
