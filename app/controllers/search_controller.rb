class SearchController < ApplicationController
  def search
    if not params.has_key?(:q)
      redirect_to "/"
      return
    end

    @results = PgSearch.multisearch(params[:q]).limit(10)
  end
end
