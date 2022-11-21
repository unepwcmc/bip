class BiodiversityIndicatorsController < ApplicationController
  include Paginatable

  def index
    @indicators = Comfy::Cms::Page.find_by_label('Indicators')
                                  .descendants
                                  .sort_by(&:label)
    @indicators = paginate_results(@indicators, params[:page], params[:per_page])
  end
end
