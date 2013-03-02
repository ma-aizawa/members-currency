class ApplicationController < ActionController::Base
  before_filter :login_setting

  protect_from_forgery

  def login_setting
    @login_now = login?
  end

  def save_login(member_id)
    session[:login] = member_id
  end

  def login?
    session[:login].present?
  end

  def reset_by_logout
    reset_session
  end
end
