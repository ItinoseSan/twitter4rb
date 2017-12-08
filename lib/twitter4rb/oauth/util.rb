module Twitter4rb
  module Oauth
    class Util
      def oauth_param(ck,ac)
        data = {
            'oauth_consumer_key' => ck,
            'oauth_signature_method' => 'HMAC-SHA1',
            'oauth_timestamp' => utc_timestamp,
            'oauth_nonce' => generate_nonce,
            'oauth_token' => ac,
            'oauth_version' => '1.0'
        }
        data.map { |k, v| [k, v] }
      end

      def oauth_header

      end

      def api_signature

      end

      def basic_code

      end

      def url_with_param

      end

      def utc_timestamp

      end

      def generate_nonce

      end
    end
  end
end