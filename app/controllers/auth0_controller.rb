class Auth0Controller < ApplicationController
  def callback
    auth_info = request.env['omniauth.auth']
    session[:userinfo] = auth_info['extra']['raw_info']

    redirect_to '/dashboard'
  end

  def failure
    @error_msg = request.params['message']
  end

  def logout
    reset_session
    redirect_to logout_url, allow_other_host: true
  end

  private

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: ENV['AUTH0_CLIENT_ID']
    }

    URI::HTTPS.build(host: ENV['AUTH0_DOMAIN'], path: '/v2/logout', query: request_params.to_query).to_s
  end
end
