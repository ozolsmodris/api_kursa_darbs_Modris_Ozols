require 'rest-client'
# API helper module
module API
  def self.post(url, headers: {}, cookies: {}, payload: {})
    # RestClient.log = 'stdout'
    headers['Content-Type'] = 'application/json' unless headers['Content-Type']
    headers['User-Agent'] = 'REST-API-Automation'
    RestClient::Request.execute(
      method: :post,
      url: url,
      headers: headers,
      cookies: cookies,
      payload: payload
    ) do |response|
      response
    end
  end

  def self.get(url, headers: {}, cookies: {})
    # RestClient.log = 'stdout'
    headers['Content-Type'] = 'application/json' unless headers['Content-Type']
    headers['User-Agent'] = 'REST-API-Automation'
    RestClient::Request.execute(
      method: :get,
      url: url,
      headers: headers,
      cookies: cookies
    ) do |response|
      response
    end
  end

  def self.put(url, headers: {}, cookies: {}, payload: {})
    # RestClient.log = 'stdout'
    headers['Content-Type'] = 'application/json' unless headers['Content-Type']
    headers['User-Agent'] = 'REST-API-Automation'
    RestClient::Request.execute(
      method: :put,
      url: url,
      headers: headers,
      cookies: cookies,
      payload: payload
    ) do |response|
      response
    end
  end

  def self.delete(url, headers: {}, cookies: {})
    # RestClient.log = 'stdout'
    headers['Content-Type'] = 'application/json' unless headers['Content-Type']
    headers['User-Agent'] = 'REST-API-Automation'
    RestClient::Request.execute(
      method: :delete,
      url: url,
      headers: headers,
      cookies: cookies
    ) do |response|
      response
    end
  end
end
