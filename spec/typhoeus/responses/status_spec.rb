require 'spec_helper'

describe Typhoeus::Responses::Status do
  let(:response) { Typhoeus::Response.new(options) }
  let(:options) { {} }

  describe "timed_out?" do
    context "when return code is 28" do
      let(:options) { {:return_code => 28} }

      it "return true" do
        response.should be_timed_out
      end
    end

    context "when return code is not 28" do
      let(:options) { {:return_code => 14} }

      it "returns false" do
        response.should_not be_timed_out
      end
    end
  end

  describe "#status_message" do
    context "when no header" do
      it "returns nil" do
        response.status_message.should be_nil
      end
    end

    context "when header" do
      context "when no message" do
        let(:options) { {:response_header => "HTTP/1.1 200\r\n"} }

        it "returns nil" do
          response.status_message.should be_nil
        end
      end

      context "when messsage" do
        let(:options) { {:response_header => "HTTP/1.1 200 message\r\n"} }

        it "returns message" do
          response.status_message.should eq("message")
        end
      end
    end
  end

  describe "#http_version" do
    context "when no header" do
      it "returns nil" do
        response.http_version.should be_nil
      end
    end

    context "when header" do
      context "when no http version" do
        let(:options) { {:response_header => "HTTP OK"} }

        it "returns nil" do
          response.http_version.should be_nil
        end
      end

      context "when invalid http_version" do
        let(:options) { {:response_header => "HTTP foo/bar OK"} }

        it "returns nil" do
          response.http_version.should be_nil
        end
      end

      context "when valid http_version" do
        let(:options) { {:response_header => "HTTP/1.1 OK"} }

        it "returns http_version" do
          response.http_version.should eq("1.1")
        end
      end
    end
  end

  describe "#success?" do
    context "when response code 200-299" do
      let(:options) { {:response_code => 201} }

      it "returns true" do
        response.success?.should be_true
      end
    end

    context "when response code is not 200-299" do
      let(:options) { {:response_code => 500} }

      it "returns false" do
        response.success?.should be_false
      end
    end
  end

  describe "#modified?" do
    context "when response code 304" do
      let(:options) { {:response_code => 304} }

      it "returns false" do
        response.modified?.should be_false
      end
    end

    context "when response code is not 304" do
      let(:options) { {:response_code => 500} }

      it "returns true" do
        response.modified?.should be_true
      end
    end
  end
end
