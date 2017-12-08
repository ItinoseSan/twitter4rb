module Twitter4rb
  module URL
    class ApiUrl
      def update_status_url
        'statuses/update.json'
      end

      def user_timeline_url
        'statuses/user_timeline.json'
      end

      def home_timeline_url
        'statuses/home_timeline.json'
      end
    end
  end
end