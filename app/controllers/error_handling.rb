module ErrorHandling
  protected
  def error_handle(exception)
    logger.warn exception
    logger.debug exception.backtrace
    if Rails.env.development?
      raise exception
    end
    flash[:error] = 'Error has occured!'
    redirect_to '/'
  end
end

