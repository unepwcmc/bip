module SearchIntegration
  module ForBlocks
    extend ActiveSupport::Concern
    included do
      include PgSearch

      searchable_snippets = [
        "description", "contact_point",
        "graphs_and_diagrams", "current_storyline",
        "data_and_methodology", "national_use_of_indicator"
      ]
      multisearchable against: :content, if: -> (record) {
        searchable_snippets.include?(record.identifier)
      }
    end
  end

  module ForPages
    extend ActiveSupport::Concern
    included do
      include PgSearch
      multisearchable against: :label
      pg_search_scope :search_by_label, against: :label
    end
  end
end

Comfy::Cms::Page.send(:include, SearchIntegration::ForPages)
Comfy::Cms::Block.send(:include, SearchIntegration::ForBlocks)
