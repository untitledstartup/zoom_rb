# frozen_string_literal: true

require 'httparty'

module Zoom
  class Client
    include HTTParty
    include Actions::Account
    include Actions::Billing
    include Actions::Dashboard
    include Actions::Group
    include Actions::M323Device
    include Actions::Meeting
    include Actions::Phone
    include Actions::Recording
    include Actions::Report
    include Actions::Roles
    include Actions::SipAudio
    include Actions::Token
    include Actions::User
    include Actions::Webinar
    include Actions::IM::Chat
    include Actions::IM::Group

    base_uri 'https://api.zoom.us/v2'
    headers 'Accept' => 'application/json'
    headers 'Content-Type' => 'application/json'

    def headers
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
      }
    end

    def oauth_request_headers
      {
        'Authorization' => "Basic #{auth_token}"
      }.merge(headers)
    end

    def request_headers
      {
        'Authorization' => "Bearer #{access_token}"
      }.merge(headers)
    end

    def auth_token
      Base64.encode64("#{ENV['ZOOM_APP_CLIENT_ID']}:#{ENV['ZOOM_APP_SECRET']}").delete("\n")
    end
  end
end

require 'zoom/clients/jwt'
require 'zoom/clients/oauth'
