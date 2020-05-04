# frozen_string_literal: true

module Zoom
  class Client
    class OAuth < Zoom::Client
      def initialize(config)
        Zoom::Params.new(config).require(:access_token)
        config.each { |k, v| instance_variable_set("@#{k}", v) }
        self.class.default_timeout(@timeout || 20)
      end

      def access_token
        @access_token
      end

      def refresh_access_token(refresh_token)
        url = 'https://api.zoom.us/oauth/token'
        query = {
          grant_type: 'refresh_token',
          refresh_token: refresh_token
        }
        auth = {username: Zoom.configuration.api_key, password: Zoom.configuration.api_secret}
        response = HTTParty.post(url, query: query, basic_auth: auth)
        @access_token = response.parsed_response['access_token']
        response
      end

      def self.request_access_token(code, redirect_uri)
        url = 'https://api.zoom.us/oauth/token'
        query = {
          grant_type: 'authorization_code',
          code: code,
          redirect_uri: redirect_uri
        }
        auth = {username: Zoom.configuration.api_key, password: Zoom.configuration.api_secret}
        HTTParty.post(url, query: query, basic_auth: auth)
      end
    end
  end
end
