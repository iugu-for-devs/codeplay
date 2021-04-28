require 'faraday'
require 'faraday_middleware'

# This module represents a way to connect with Iugu Lite

module IuguLite
  class << self
    # Creates a Faraday::Conection with Iugu Lite setting URL and headers
    #
    # # Using with an URL
    # IuguLite.client.get('invoices')

    def client
      @client ||= new_connection
    end

    private

    def new_connection
      Faraday.new(
        url: iugu_lite_uri,
        params: { company_token: Rails.configuration.iugu_lite_token }
      ) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.response :json, parser_options: { symbolize_names: true },
                                content_type: /\bjson$/
        faraday.adapter :net_http
      end
    end

    def iugu_lite_uri
      "#{endpoint}/api/#{api_version}/"
    end

    def endpoint
      Rails.configuration.external_apis[:iugu_lite][:url]
    end

    def api_version
      'v1'
    end
  end
end
