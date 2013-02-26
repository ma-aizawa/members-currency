class LogForCurrenciesController < ApplicationController
  def index
    @logs = LogForCurrency.all
  end
end
