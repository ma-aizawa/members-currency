class CurrenciesController < ApplicationController
  def index
    @currenies = Currency.all
  end

  def show
    @currency = Currency.find(:first, conditions: {id: params[:id]})
    @logs = LogForCurrency.find(:all, conditions: {currency_id: @currency.currency_id})
  end
end

