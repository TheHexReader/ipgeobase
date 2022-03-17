# frozen_string_literal: true

require_relative 'ipgeobase/version'

require 'addressable/uri'
require 'happymapper'
require 'net/http'

# This module gets metadata by ip
module Ipgeobase
  class Error < StandardError; end

  def self.lookup(ip)
    uri = Addressable::URI.parse("http://ip-api.com/xml/#{ip}")
    response = Net::HTTP.get_response(uri)
    GeoBase.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  end

  class GeoBase
    include HappyMapper
    tag 'query'
    element :city, String, tag: 'city'
    element :country, String, tag: 'country'
    element :countryCode, String, tag: 'countryCode'
    element :lat, Float, tag: 'lat'
    element :lon, Float, tag: 'lon'
  end
end
