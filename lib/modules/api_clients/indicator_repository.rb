# frozen_string_literal: true

module ApiClients::IndicatorRepository
  class << self
    include HTTParty

    BASE_URL = Rails.application.secrets.indicator_api_url
    INDICATOR_TYPES = %w[headline component complementary]

    def list(indicator_name)
      INDICATOR_TYPES.each do |type|
        response = HTTParty.post(BASE_URL + "/#{type}_indicators/api/v1" + '?items_per_page=250')
        indicator = response['items'].select { |item| item['indicator_name'] == indicator_name }

        break indicator if indicator.any?
      end
    end
  end
end
