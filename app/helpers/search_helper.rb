module SearchHelper
  def search_result result, query
    doc = Nokogiri::HTML(result.content)
    text = doc.xpath("//*[contains(text(), '#{query}')]").first.to_s

    regex = Regexp.new("(#{params[:q]})", true)
    raw(text.gsub(regex, '<strong>\1</strong>'))
  end
end
