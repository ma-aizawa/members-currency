class LogForCurrenciesController < ApplicationController
  def index
    @logs = LogForCurrency.all(order: 'operation_date desc')
  end
end
