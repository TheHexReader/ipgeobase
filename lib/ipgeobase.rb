# frozen_string_literal: true

require_relative 'ipgeobase/version'
require_relative 'ipgeobase/geobase'

require 'addressable/uri'
require 'net/http'

# This module gets metadata by ip
module Ipgeobase
  IP_API_URL = 'http://ip-api.com/xml/'
  def self.lookup(ip)
    uri = Addressable::URI.parse(IP_API_URL + ip)
    response = Net::HTTP.get_response(uri)
    Ipgeobase::GeoBase.parse(response.body) if response.is_a?(Net::HTTPSuccess)
  end
end
