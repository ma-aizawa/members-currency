class MoneyTicketsController < ApplicationController
  def index
    @tickets = MoneyTicket.all
  end

  def new
    @ticket = MoneyTicket.new
  end

  def create

    redirect_to money_tickets_path
  end

  def exchange
    redirect_to members_path and return unless login?

    @currencies = Currency.all
    @amounts = AmountOfCurrency.find(:all, conditions: {member_id: get_login_member_id})
  end

  def confirm_exchange
    redirect_to members_path and return unless login?

    @currency = Currency.get(params[:exchange][:currency])
    @amount = AmountOfCurrency.new
    @amount.amount = params[:exchange][:amount]
  end

  def use
    redirect_to members_path and return unless login?

    if params[:cancel]
      redirect_to exchange_point_path and return
    end

    exchange_currency_id = params[:exchange][:currency]
    exchange_amount = params[:exchange][:amount].to_i

    login_member = Member.get(get_login_member_id)

    amount_of_member = AmountOfCurrency.get(login_member.member_id, exchange_currency_id)

    if amount_of_member.amount < exchange_amount
      flash[:error] = t('message.less_amount_for_exchange')
      logger.warn "Error!! Illegal exchange. currency:#{exchange_currency_id}, member:#{login_member.member_id}, amount:#{exchange_amount}"
      redirect_to login_member and return
    end

    begin
      login_member.exchange(exchange_amount).of(exchange_currency_id).run
    rescue Exception => ex
      logger.warn ex
      logger.debug ex.backtrace
      flash[:alert] = t('message.ticket_insufficient')
      redirect_to login_member and return
    end

    flash[:notice] = t('message.success_exchange', currency: Currency.get(exchange_currency_id).name, amount: exchange_amount)
    redirect_to login_member and return
  end

  private
  def consistent_exchange?
    true
  end
end

