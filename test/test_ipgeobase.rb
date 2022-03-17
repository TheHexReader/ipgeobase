# frozen_string_literal: true

require_relative '../lib/ipgeobase'

require 'test_helper'

class TestIpgeobase < Minitest::Test
  def setup
    @test_values = {
      city: 'Ashburn',
      country: 'United States',
      countryCode: 'US',
      lat: 39.03,
      lon: -77.5
    }
  end
    
  def test_lookup
    stub_request_body = '<?xml version="1.0" encoding="UTF-8"?>
      <query>
        <status>success</status>
        <country>United States</country>
        <countryCode>US</countryCode>
        <region>VA</region>
        <regionName>Virginia</regionName>
        <city>Ashburn</city>
        <zip>20149</zip>
        <lat>39.03</lat>
        <lon>-77.5</lon>
        <timezone>America/New_York</timezone>
        <isp>Google LLC</isp>
        <org>Google Public DNS</org>
        <as>AS15169 Google LLC</as>
        <query>8.8.8.8</query>
      </query>'
    stub_request(:get, 'http://ip-api.com/xml/8.8.8.8').
    to_return(status: 200, body: stub_request_body)
    input = Ipgeobase.lookup('8.8.8.8')
    assert(input.city == @test_values[:city])
    assert(input.country == @test_values[:country])
    assert(input.countryCode == @test_values[:countryCode])
    assert(input.lat == @test_values[:lat])
    assert(input.lon == @test_values[:lon])
  end
end
