class CurrenciesController < ApplicationController
  def index
    @currenies = Currency.all
  end
end

