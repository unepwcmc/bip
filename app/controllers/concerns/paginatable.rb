module Paginatable
  extend ActiveSupport::Concern

  included do
    private

    def paginate_results results, page, per_page
      @total_results = results.count
      
      @page_index = [0, page.to_i].max
      @current_page = @page_index + 1
      @per_page = (per_page || 10).to_i
      @total_pages = (results.count.to_f / @per_page).ceil
  
      @from = @page_index * @per_page
      @to = @from + (@per_page - 1)
      @to = [@total_results - 1, @to].min
  
      results[@from..@to] || []
    end
  end
end