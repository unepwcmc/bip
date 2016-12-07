class SearchController < ApplicationController
  def search
    if !params.has_key?(:q) && !params.has_key?(:filters)
      redirect_to "/"
      return
    end

    if params.has_key?(:q)
      @results = PgSearch.multisearch(params[:q]).map(&:searchable).uniq do |r|
        if r.is_a?(Comfy::Cms::Block)
          r.blockable.label
        else
          r.label
        end
      end
    else
      @results = Comfy::Cms::Page.find_by_label("Indicators").descendants
    end

    pages = extract_pages(@results)

    @all_filters = {
      aichi_targets: pages.flat_map(&:aichi_targets).uniq.sort_by(&:target_number),
      sdgs: pages.flat_map(&:sdg_targets).map(&:sdg_goal).uniq.sort_by(&:position),
      meas: pages.flat_map(&:mea_targets).map(&:mea).uniq.sort_by(&:name),
      themes: pages.flat_map(&:themes).uniq.sort_by(&:name)
    }

    @results = @results.select { |r|
      if r.is_a?(Comfy::Cms::Block)
        r.blockable.ancestors.map(&:label).include?("Indicators")
      else
        r.ancestors.map(&:label).include?("Indicators")
      end
    }
    @results = filter_results(@results, params[:filters]) if params[:filters]
    @total_results = @results.size
    @results = paginate_results(@results, params[:page], params[:per_page])

    if @page > 0 && @results.size == 0
      redirect_to url_for(params.merge(page: 0))
    end
  end

  private

  def filter_results(results, filters)
    results.select { |r|
      conditions = []
      indicator = r.is_a?(Comfy::Cms::Block) ? r.blockable : r

      if target_ids = filters[:aichi_targets]
        target_ids = target_ids.map(&:to_i)
        conditions << (indicator.aichi_target_ids & target_ids).any?
      end
      if sdg_ids = filters[:sdgs]
        sdg_ids = sdg_ids.map(&:to_i)
        conditions << (indicator.sdg_targets.flat_map(&:sdg_goal_id) & sdg_ids).any?
      end
      if mea_ids = filters[:meas]
        mea_ids = mea_ids.map(&:to_i)
        conditions << (indicator.mea_targets.flat_map(&:mea_id) & mea_ids).any?
      end
      if theme_ids = filters[:themes]
        theme_ids = theme_ids.map(&:to_i)
        conditions << (indicator.theme_ids & theme_ids).any?
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
    @page = [0, page.to_i].max

    @from = @page * @per_page
    @to = @from + (@per_page - 1)

    results[@from..@to] || []
  end
end
