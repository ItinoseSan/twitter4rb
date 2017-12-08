module Twitter4rb
  module URL
    class Encoder
      def url_encode(param_string)
        encoded_param = URI.escape(param_string).force_encoding('utf-8')
        replace_param = encoded_param.to_s
        replace_param.gsub!(/+/,'%20')
      end
    end
  end
end