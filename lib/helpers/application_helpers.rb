module Sinatra
  module Ewallet
    module ApplicationHelpers
      def request_body
        return if request.get?
        request.body.rewind

        ::JSON.parse(request.body.read, symbolize_names: true)
      end

      def issue_token(key, data = {})
        default_data = {
          iss: 'ewallet',
          iat: Time.now.to_i,
          exp: Time.now.to_i + 60 * 60 * 12
        }

        ::JWT.encode(data.merge(default_data), key, 'RS256')
      end

      def current_user
        @user = User.first(id: request.env['user'])
      end
    end
  end

  helpers Ewallet::ApplicationHelpers
end