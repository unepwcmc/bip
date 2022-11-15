class BiodiversityIndicatorsController < ApplicationController
  def index
    @indicators = Comfy::Cms::Page.find_by_label('Indicators')
                                  .descendants
                                  .sort_by(&:label)
    @total_count = @indicators.size
    @indicators = paginate_results(@indicators, params[:page], params[:per_page])
  end

  private

  def paginate_results(results, page, per_page)
    @per_page = (per_page || 10).to_i
    @page = [0, page.to_i].max

    @from = @page * @per_page
    @to = @from + (@per_page - 1)

    results[@from..@to] || []
  end
end
