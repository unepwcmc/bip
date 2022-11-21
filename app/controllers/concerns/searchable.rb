module Searchable
  extend ActiveSupport::Concern

  included do
    private

    def search_results
      PgSearch.multisearch(params[:q]).map(&:searchable).uniq do |r|
        r.is_a?(Comfy::Cms::Block) ? r.blockable.label : r.label
      end
    end

    def extract_pages results
      results.map { |result|
        result.is_a?(Comfy::Cms::Block) ? result.blockable : result
      }
    end
  end
end