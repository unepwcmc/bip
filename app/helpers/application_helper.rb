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

  def page_class_name
    "#{controller_name}-#{action_name}".downcase
  end

  def text_or_na text
    text.present? ? text : "N/A"
  end

  def default_if_not_present(text, default)
    text.present? ? text : default
  end
  
  def nav_items
    [
      {
        label: "About",
        link: "/about"
      },
      {
        label: "Biodiversity Indicators",
        link: "/biodiversity-indicators"
      },
      {
        label: "Indicator Development",
        link: "/national-indicator-development"
      },
      {
        label: "Partners",
        link: "/partners"
      },
      {
        label: "Resources",
        link: resources_path(filters: { category: Comfy::Cms::Page.find_by_label("Resources")&.children.first&.id })
      },
      {
        label: "Dashboard",
        link: "http://bipdashboard.natureserve.org/bip"
      }
    ]
  end
end
