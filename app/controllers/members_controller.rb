class MembersController < ApplicationController
  def index
    @members = Member.all  end

  def show
    @member = Member.find(:first, conditions: {id: params[:id]})
    currency_list = Currency.all
    currency_list.each do |currency|
      @member.set_currency_info(currency)
      @member.calculate_currency(currency.currency_id)
    end
  end
end
