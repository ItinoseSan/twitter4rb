require 'base64'
require 'time'
require 'openssl'
require 'twitter4rb/URL/encoder'

module Twitter4rb
  module Oauth
    class Util
      def initialize
        @encoder = Twitter4rb::URL::Encoder.new
      end

      def oauth_param(ck, ac)
        data = {
            'oauth_consumer_key' => ck,
            'oauth_signature_method' => 'HMAC-SHA1',
            'oauth_timestamp' => utc_timestamp,
            'oauth_nonce' => 'a',
            'oauth_token' => ac,
            'oauth_version' => '1.0'
        }
        data.map { |k, v| [k, v] }
      end

      def oauth_header(signature, oauth_param, cks, ats)
        compo_key = @encoder.url_encode(cks) + "&" + @encoder.url_encode(ats)
        oauth_signature = basic_code(signature, compo_key)
        encoded_signature = @encoder.url_encode(oauth_signature)

        auth_header_temp = "OAuth oauth_consumer_key=\"%s\", oauth_nonce=\"%s\", oauth_signature=\"%s\", " +
            "oauth_signature_method=\"%s\", oauth_timestamp=\"%s\", oauth_token=\"%s\", oauth_version=\"%s\""
        String.format(auth_header_temp,
                            oauth_param['oauth_consumer_key'],
                                 oauth_param['oauth_nonce'],
                                 encoded_signature,
                                 oauth_param['oauth_signature_method'],
                                 oauth_param['oauth_timestamp'],
                                 oauth_param['oauth_token'],
                                 oauth_param['oauth_version'])
      end

      def api_signature(method, url, param, oauth_param)
        tree_param = {}
        tree = tree_param.map { |k, v| [k, v] }
        putall = tree + param + oauth_param

        paramStr = putall
        temp = '%s&%s&%s'
        signature = String.format(temp, @encoder.url_encode(method),
        @encoder.url_encode(url), @encoder.url_encode(paramStr))
        signature
      end

      def basic_code(signature, key)
        key_byte = key.getbyte
        text = signature.getbyte
        hmac_instance = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha256'),
                             key_byte, text).unpack("H*")
        Base64.encode64(hmac_instance)
      end

      def url_with_param(url, data, method)
        tree = data + '='
        if method == 'POST'
          tree + '&'
        else
          tree + '?'
        end
      end

      def utc_timestamp
        time_zone = Time.now.utc.iso8601
        time_zone / 1000
      end

      def generate_nonce

      end
    end
  end
end