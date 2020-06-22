require 'faraday'
require 'json'
require 'net/http'
require 'uri'

module Moncash
  class Hit
    attr_accessor :client_id, :secret_id

    @@token_endpoint = '/Api/oauth/token'
    @@new_payment_endpoint = '/Api/v1/CreatePayment'
    @base_url = ''
    @token = ''
    @payment_repons = ''

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

    def create_payment(amount, order_id, mode = 'sanbox')
      create_token(mode)
      uri = URI.parse("https://#{@base_url}#{@@new_payment_endpoint}")
      request = Net::HTTP::Post.new(uri)
      request.content_type = 'application/json'
      request['Accept'] = 'application/json'
      request['Authorization'] = "Bearer #{@token}"
      request.body = JSON.dump({
                                 'amount' => amount,
                                 'orderId' => order_id
                               })
      req_options = {
        use_ssl: uri.scheme == 'https'
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      @payment_repons = JSON.parse response.body
    end

    def get_payment_detail(order_id, mode = 'sandbox')
      create_token(mode)
      uri = URI.parse("https://#{@base_url}#{@@get_payment_endpoint}")
      request = Net::HTTP::Post.new(uri)
      request.content_type = 'application/json'
      request['Accept'] = 'application/json'
      request['Authorization'] = "Bearer #{@token}"
      request.body = "{ \" transactionId\": #{order_id}}"
      req_options = {
        use_ssl: uri.scheme == 'https'
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      JSON.parse response.body
    end
  end
end
