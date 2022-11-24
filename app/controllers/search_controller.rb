class SearchController < ApplicationController
  include Paginatable
  include Searchable

  def search
    if !params.has_key?(:q) && !params.has_key?(:filters) || params[:q].downcase == "aichi"
      redirect_to "/"
      return
    end

    if params.has_key?(:q)
      @results = search_results
    else
      @results = Comfy::Cms::Page.find_by_label("Indicators").descendants
    end

    pages = extract_pages(@results)

    @all_filters = {
      aichi_targets: pages.flat_map(&:aichi_targets).uniq.compact.sort_by(&:target_number),
      sdgs: pages.flat_map(&:sdg_targets).map(&:sdg_goal).uniq.compact.sort_by(&:position),
      meas: pages.flat_map(&:mea_targets).map(&:mea).uniq.compact.sort_by(&:name),
      themes: pages.flat_map(&:themes).uniq.compact.sort_by(&:name),
      indicators: pages.flat_map(&:indicator_type).uniq.compact.sort_by(&:name)
    }

    @results = @results.select { |r|
      if r.is_a?(Comfy::Cms::Block)
        r.blockable.ancestors.map(&:label).include?("Indicators")
      else
        r.ancestors.map(&:label).include?("Indicators")
      end
    }
    @results = filter_results(@results, params[:filters]) if params[:filters]
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

      # if target_ids = filters[:aichi_targets]
      #   target_ids = target_ids.map(&:to_i)
      #   conditions << (indicator.aichi_target_ids & target_ids).any?
      # end
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
      if indicator_ids = filters[:indicators]
        indicator_ids = indicator_ids.map(&:to_i)
        conditions << ([indicator.indicator_type_id] & indicator_ids).any?
      end

      conditions.all?
    }
  end
end
