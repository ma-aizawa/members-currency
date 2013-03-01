class ApplicationController < ActionController::Base
  protect_from_forgery

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
