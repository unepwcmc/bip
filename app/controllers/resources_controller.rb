class ResourcesController < ApplicationController
  include Paginatable

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
    @results = @results.select { |r| r.resources.any? }
    @results = filter_results(@results, params[:filters]) if params[:filters]
    @results = @results.sort_by(&:created_at)
    @results = paginate_results(@results, params[:page], params[:per_page])

    if @page_index > 0 && @results.size == 0
      redirect_to url_for(params.merge(page: 0))
    end
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
end
