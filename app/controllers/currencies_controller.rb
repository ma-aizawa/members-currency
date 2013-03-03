# -*- encoding: UTF-8 -*-
class CurrenciesController < ApplicationController
  def index
    @currenies = Currency.all
  end

  def show
    @currency = Currency.find(:first, conditions: {id: params[:id]})
    @logs = LogForCurrency.find(
      :all,
      conditions: {
        currency_id: @currency.currency_id
      },
      order: 'operation_date desc'
    )
  end

  def new
    @currency = Currency.new
  end

  def create
    currency = Currency.new.load_data(params[:currency])
    currency.set_publisher(get_login_member_id).generate_currency_id

    if currency.invalid?
      @currency = currency
      flash.now[:error] = "登録データに誤りがあります。もう一度入力してください。"
      render :new and return
    end

    currency.save
    redirect_to currency
  end

  def destroy
    primary_key = params[:id]
    currency = Currency.find(:first, conditions: {id: primary_key})
    logger.info "Delete #{currency.name}"
    currency.delete
    redirect_to currencies_path
  end

  def publish
    @currency = Currency.get(params[:currency_id])
  end

  def add_amount
    publisher = Member.get(get_login_member_id)
    currency = Currency.get(params[:currency_id])
    amount = params[:add_amount]
    distribution_members = params[:distribution_members]
    amount_per_member = params[:member_amount]

    currency.add(amount).of(currency).to(distribution_members).per(amount_per_member).by(publisher).run

    flash[:notice] = "Publish to members!"
    redirect_to action: :index
  rescue Exception => ex
    flash.now[:alert] = 'Some error has occured. Please try again.'
    logger.warn ex
    logger.debug ex.backtrace

    @currency = currency
    render :publish
  end
end

