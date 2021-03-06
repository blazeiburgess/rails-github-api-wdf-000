class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end
    byebug
    session[:token] = resp.body.scan(/access_token=(\w+)&/).first.first
    redirect_to root_path
  end
end
