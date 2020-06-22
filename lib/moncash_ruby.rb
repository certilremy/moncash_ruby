require 'faraday'
require 'json'
require 'net/http'
require 'uri'

module Moncash
  class Hit
    attr_accessor :client_id, :secret_id

    @@token_endpoint = '/Api/oauth/token'
    @base_url = 'live'
    @token = ''

    def initialize(client_id, secret_id)
      @client_id = client_id
      @secret_id = secret_id
    end

    def create_token(mode)
      if mode == 'sanbox'
        @base_url = 'sandbox.moncashbutton.digicelgroup.com'
      elsif mode == 'live'
        @base_url = 'moncashbutton.digicelgroup.com'
      end
      conn = Faraday.new(url: "https://#{client_id}:#{secret_id}@#{@base_url}") do |faraday|
        faraday.adapter Faraday.default_adapter
      end

      response = conn.post do |req|
        req.url @@token_endpoint
        req.headers['Content-Type'] = 'application/json'
        req.params = { scope: 'read,write', grant_type: 'client_credentials' }
      end
      repos = JSON.parse response.body
      @token = repos['access_token']
    end
   end
  end
