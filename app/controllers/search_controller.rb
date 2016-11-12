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
  end
end
