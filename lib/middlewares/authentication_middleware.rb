module Ewallet
  class AuthenticationMiddleware
    def initialize(app, public_key, **options)
      @app = app
      @except_for = options.fetch(:except_for, [])
      @public_key = OpenSSL::PKey.read(public_key)
    end

    def call(env)
      @request = Rack::Request.new(env)

      return @app.call(env) if @except_for.any? { |path| @request.path =~ Regexp.new(path) }

      begin
        options = { algorithm: 'RS256', issuer: 'ewallet' }
        bearer = env.fetch('HTTP_AUTHORIZATION', '').slice(7..-1)
        payload, header = ::JWT.decode(bearer, @public_key, true, options)

        env['user'] = payload['id']

        @app.call(env)
      rescue JWT::DecodeError
        [401, { 'Content-Type' => 'text/plain' }, ['You need to provide a valid access token']]
      rescue JWT::ExpiredSignature
        [403, { 'Content-Type' => 'text/plain' }, ['The provided token has expired.']]
      rescue JWT::InvalidIssuerError
        [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid issuer.']]
      rescue JWT::InvalidIatError
        [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid "issued at" time.']]
      end
    end
  end
end