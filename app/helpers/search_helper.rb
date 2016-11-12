module SearchHelper
  def search_result result, query
    if result.is_a?(Comfy::Cms::Block)
      doc = Nokogiri::HTML(result.content)

      translation = "translate(., '#{query.upcase}', '#{query.downcase}')"
      text = doc.xpath("//p[contains(#{translation}, #{query})]").first.to_s

      regex = Regexp.new("(#{params[:q]})", true)
      raw(text.gsub(regex, '<strong>\1</strong>'))
    else
      doc = Nokogiri::HTML(result.content_cache)
      text = doc.xpath("//p[contains(text(), ' ')]").first.to_s
      raw(text)
    end
  end
end
