module ErrorHandling
  protected
  def error_handle(exception)
    logger.warn exception
    logger.debug exception.backtrace
    flash[:error] = 'Error has occured!'
    redirect_to '/'
  end
end

