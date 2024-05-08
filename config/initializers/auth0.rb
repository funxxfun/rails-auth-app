AUTH0_CONFIG = Rails.application.config_for(:auth0)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    AUTH0_CONFIG['auth0_client_id'] => ENV['AUTH0_CLIENT_ID'],
    AUTH0_CONFIG['auth0_client_secret'] => ENV['AUTH0_CLIENT_SECRET'],
    AUTH0_CONFIG['auth0_domain'] ENV['AUTH0_DOMAIN'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end
