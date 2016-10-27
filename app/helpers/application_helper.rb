module ApplicationHelper
  def breadcrumb text, path=nil
    capture do
      concat content_tag(:i, "", class: "angle-right breadcrumbs__divider")
      concat(path ? link_to(text, path) : text)
    end
  end
end
