module CmsHelper
  def link_to_cms_page icca_site, site
    page = icca_site.pages.where(site_id: site.id).first

    if page
      link_to(
        "Edit CMS page",
        edit_comfy_admin_cms_site_page_path(site_id: site, id: page.id),
        class: "btn btn-default"
      )
    else
      ""
    end
  end

  def target_title target_rel, type
    content_tag(:h5, class: "target__title") do
      if type == :mea
        concat target_rel.send("#{type}_target").target_title
      else
        concat "Target #{target_rel.send("#{type}_target").target_number}"
      end

      if target_rel.official
        concat content_tag(:span, "| Official indicator", class: "target__subtitle target__subtitle--bold")
      else
        concat content_tag(:span, "| Relevant indicator", class: "target__subtitle target__subtitle")
      end
    end
  end

  def default_available_link_title
    @cms_page.available_link_alternate.empty? ? 'Resource link' : 'Resource link 1'
  end

  def default_available_link_title_alternate
   'Resource link 2'
  end

  def available_link_title
    default_if_empty(@cms_page.available_link_title, default_available_link_title)
  end

  def available_link_title_alternate
    default_if_empty(@cms_page.available_link_title_alternate, default_available_link_title_alternate)
  end
end
