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
    @test_ip = '8.8.8.8'
    body = File.read('./test/fixtures/ip_api_stub.xml')
    stub_request(:get, IP_API_URL + @test_ip).to_return(status: 200, body: body)
  end

  def test_lookup
    input = Ipgeobase.lookup(@test_ip)
    assert(input.city == @test_values[:city])
    assert(input.country == @test_values[:country])
    assert(input.countryCode == @test_values[:countryCode])
    assert(input.lat == @test_values[:lat])
    assert(input.lon == @test_values[:lon])
  end
end
