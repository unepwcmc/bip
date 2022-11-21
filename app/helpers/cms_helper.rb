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
    @cms_page.available_link_alternate.present? ? 'Resource link 1' : 'Resource link'
  end

  def default_available_link_title_alternate
   'Resource link 2'
  end

  def available_link_title
    default_if_not_present(@cms_page.available_link_title, default_available_link_title)
  end

  def available_link_title_alternate
    default_if_not_present(@cms_page.available_link_title_alternate, default_available_link_title_alternate)
  end

  def national_indicators
    [
      {
        name: 'Africa',
        href: '/national-indicator-development/national-data/africa',
        title: 'National Indicators: Africa'
      },
      {
        name: 'Asia & Pacific',
        href: '/national-indicator-development/national-data/asia-pacific',
        title: 'National Indicators: Asia & Pacific'
      },
      {
        name: 'Europe',
        href: '/national-indicator-development/national-data/europe',
        title: 'National Indicators: Europe'
      },
      {
        name: 'Latin America & Caribbean',
        href: '/national-indicator-development/national-data/latin-america-caribbean',
        title: 'National Indicators: Latin America & Caribbean'
      },
      {
        name: 'North America',
        href: '/national-indicator-development/national-data/north-america',
        title: 'National Indicators: North America'
      },
      {
        name: 'Polar',
        href: '/national-indicator-development/national-data/polar',
        title: 'National Indicators: Polar'
      },
      {
        name: 'West Asia',
        href: '/national-indicator-development/national-data/west-asia',
        title: 'National Indicators: West Asia'
      }
    ]
  end

  def homepage_tabs
    [
      {
        name: 'SDGs',
        id: 'sdgs'
      },
      {
        name: 'MEAs',
        id: 'meas'
      },
      {
        name: 'Themes',
        id: 'themes'
      },
      {
        name: 'National Indicators',
        id: 'indicators'
      }
     ]
  end
end
