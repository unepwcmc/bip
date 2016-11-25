class ResourcesController < ApplicationController
  def index
    if params.has_key?(:q)
      @results = PgSearch.multisearch(params[:q]).map(&:searchable).uniq do |r|
        r.is_a?(Comfy::Cms::Block) ? r.blockable.label : r.label
      end
    else
      @results = Comfy::Cms::Page.find_by_label("Resources").descendants
    end

    pages = extract_pages(@results)

    @all_filters = {
      tags: pages.flat_map(&:tags).uniq.sort_by(&:name)
    }

    @tabs = Comfy::Cms::Page.find_by_label("Resources").children
    @results = filter_results(@results, params[:filters]) if params[:filters]
    @results = paginate_results(@results, params[:page], params[:per_page])
  end

  private

  def filter_results(results, filters)
    results.select { |r|
      conditions = []
      indicator = r.is_a?(Comfy::Cms::Block) ? r.blockable : r

      if tag_ids = filters[:tags]
        tag_ids = tag_ids.map(&:to_i)
        conditions << (indicator.other_tag_ids & tag_ids).any?
      end

      if category_id = filters[:category]
        conditions << indicator.ancestors.map(&:id).include?(category_id.to_i)
      end

      conditions.all?
    }
  end

  def extract_pages results
    results.map { |result|
      result.is_a?(Comfy::Cms::Block) ? result.blockable : result
    }
  end

  def paginate_results results, page, per_page
    @per_page = (per_page || 10).to_i
    @page = page.to_i

    @from = @page * @per_page
    @to = @from + (@per_page - 1)

    results[@from..@to]
  end
end