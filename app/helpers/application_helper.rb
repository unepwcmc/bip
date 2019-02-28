module ApplicationHelper
  def breadcrumb text, path=nil, first=false
    capture do
      unless first
        concat content_tag(:i, "", class: "fa fa-angle-right breadcrumbs__divider")
      end

      concat(
        path ?
        link_to(text, path, class: "breadcrumbs__element breadcrumbs__element--link") :
        content_tag(:span, text, class: "breadcrumbs__element")
      )
    end
  end

  def text_or_na text
    text.present? ? text : "N/A"
  end

  def default_if_empty(text, default)
    text.empty? ? default : text
  end
end
