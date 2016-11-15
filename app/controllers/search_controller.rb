class SearchController < ApplicationController
  def search
    if not params.has_key?(:q)
      redirect_to "/"
      return
    end

    @results = PgSearch.multisearch(params[:q]).map(&:searchable).uniq do |r|
      if r.is_a?(Comfy::Cms::Block)
        r.blockable.label
      else
        r.label
      end
    end

    @results = filter_results(@results, params[:filters]) if params[:filters]
    pages = extract_pages(@results)

    @all_filters = {
      aichi_targets: pages.flat_map(&:aichi_targets).sort_by(&:target_number),
      sdgs: pages.flat_map(&:sdg_targets).map(&:sdg_goal).uniq.sort_by(&:position),
      meas: pages.flat_map(&:mea_targets).map(&:mea).uniq.sort_by(&:name),
      themes: pages.flat_map(&:themes).uniq.sort_by(&:name)
    }
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
end
