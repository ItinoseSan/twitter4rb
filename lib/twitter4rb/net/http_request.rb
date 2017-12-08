require 'twitter4rb/oauth/util'
require 'net/http'
require 'uri'

module Twitter4rb
  module Net
    class HttpRequest
      def initialize
        @oauth = Twitter4rb::Oauth::Util.new
      end

      def end_point_url
        'https://api.twitter.com/1.1/'
      end

      def post(data, url, ck, ac, cks, ats)
        full_url = end_point_url + url
        oauth_map = @oauth.oauth_param(ck, ac)
        oauth_signature = @oauth.api_signature('POST', full_url,
                                               data, oauth_map)
        oauth_header = @oauth.oauth_header(oauth_signature,
                                           oauth_map, cks, ats)

        uri = URI.parse(full_url)
        Net::HTTP.start(uri.host, uri.port) {|http|
        header = {'Authorization' => oauth_header
        }
          http.post(uri.path,header)
        }
      end

      def get(data, url, ck, ac, cks, ats)

      end
    end
  end
end