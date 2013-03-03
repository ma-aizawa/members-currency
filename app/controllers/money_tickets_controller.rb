class MoneyTicketsController < ApplicationController
  def index
    @tickets = MoneyTicket.all
  end
end
