require 'spec_helper'

describe Typhoeus::Requests::Responseable do
  let(:request) { Typhoeus::Request.new("url", {}) }
  let(:response) { Typhoeus::Response.new }

  describe "#response=" do
    it "stores response" do
      request.response = response
      request.response.should eq(response)
    end
  end
end
