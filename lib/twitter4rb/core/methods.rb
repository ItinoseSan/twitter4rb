require 'twitter4rb/URL/api_url'
require 'twitter4rb/net/http_request'
require 'twitter4rb/URL/encoder'

module Twitter4rb
  module Core
    class Methods
      def initialize(ck, cks, ac, acs)
        @consumer_key = ck
        @consumer_secret_key = cks
        @access_token = ac
        @access_token_secret = acs
        @http_request = Twitter4rb::Net::HttpRequest.new
        @api_url = Twitter4rb::URL::ApiUrl.new
        @url_encoder = Twitter4rb::URL::Encoder.new
      end

      def tweet(text)
        encoded_text = @url_encoder.url_encode(text)
        param = { 'status' => encoded_text, 'trim_user' => '1'}
        data = param.map { |k, v| [k, v] }
        update_url = @api_url.update_status_url
        @http_request.post(data, update_url, @consumer_key, @access_token,
                                  @consumer_secret_key, @access_token_secret)
      end

      def home_timeline(counter)

      end

      def user_timeline(couter)

      end

    end
  end
end