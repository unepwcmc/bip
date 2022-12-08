# frozen_string_literal: true

module ApiClients::IndicatorRepository
  class << self
    include HTTParty

    BASE_URL = Rails.application.secrets.indicator_api_url
    INDICATOR_TYPES = %w[headline component complementary]

    def list(indicator_name)
      indicator = {}
      INDICATOR_TYPES.each do |type|
        response = HTTParty.post(BASE_URL + "/#{type}_indicators/api/v1" + '?items_per_page=250')
        indicator = response['items'].find { |item| indicator_name == sanitize_indicator_name(item['indicator_name']) }

        return indicator if indicator.present?
      end
      indicator
    end

    # this is a workaround to select the correct(the headline one) indicator name
    # from the API where multiple indicators share the same name but
    # the number/id prefix e.g.:
    # A.3 Red List Index(headline), Red List index(component), Red List index(complementary)
    def sanitize_indicator_name(name)
      name.split(' ').first =~ /\d/ ? name.split(' ')[1..-1].join(' ') : name
    end
  end
end
