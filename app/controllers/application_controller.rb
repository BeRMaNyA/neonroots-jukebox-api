class ApplicationController < ActionController::Base
  protect_from_forgery

  layout false

  protected

  def authenticate_admin
    authenticate_or_request_with_http_token do |token, options|
      token == ENV["ADMIN_TOKEN"]
    end
  end

  def authenticate_bar_owner
    authenticate_or_request_with_http_token do |token, options|
      bar = Bar.find_by_token(token)
      !bar.nil?
    end
  end

  def authenticate_admin_or_bar_owner
    authenticate_or_request_with_http_token do |token, options|
      bar = Bar.find_by_token(token)
      token == ENV["ADMIN_TOKEN"] || !bar.nil?
    end
  end
end
