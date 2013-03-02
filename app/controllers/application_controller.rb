class ApplicationController < ActionController::Base
  include ErrorHandling

  before_filter :login_setting
  rescue_from Exception, with: :error_handle

  protect_from_forgery

  def login_setting
    @login_now = login?
  end

  def save_login(member_id)
    session[:login] = member_id
  end

  def get_login_member_id
    session[:login]
  end

  def login?
    session[:login].present?
  end

  def reset_by_logout
    reset_session
  end
end
