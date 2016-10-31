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
end
