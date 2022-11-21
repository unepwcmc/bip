class ResourcesController < ApplicationController
  include Paginatable
  include Searchable

  def index
    @tabs = Comfy::Cms::Page.find_by_label("Resources").children
    @all_resources = all_resources

    if params.has_key?(:q)
      @results = Comfy::Cms::Page
        .search_by_label(params[:q])
        .where('id IN (?)', @all_resources.map(&:id))
    else
      @results = @all_resources
    end

    pages = extract_pages(@results)

    @all_filters = {
      tags: pages.flat_map(&:tags).uniq.sort_by(&:name)
    }

    @results = @results.select { |r| r.resources.any? }
    @results = filter_results(@results, params[:filters]) if params[:filters]
    @results = @results.sort_by(&:created_at)
    @results = paginate_results(@results, params[:page], params[:per_page])

    if @page_index > 0 && @results.size == 0
      redirect_to url_for(params.merge(page: 0))
    end
  end

  private

  def all_resources
    tab_page_ids = @tabs.map(&:id)

    Comfy::Cms::Page.find_by_label("Resources")
      .descendants
      .select { |page| !tab_page_ids.include?(page.id) }
  end

  def filter_results(results, filters)
    results.select { |r|
      conditions = []

      if tag_ids = filters[:tags]
        tag_ids = tag_ids.map(&:to_i)
        conditions << (r.other_tag_ids & tag_ids).any?
      end

      if category_id = filters[:category]
        conditions << r.ancestors.map(&:id).include?(category_id.to_i)
      end

      conditions.all?
    }
  end
end
