class Member < ActiveRecord::Base
  attr_accessible :member_id, :name, :profile
  attr_accessor :currency_list

  def set_currency_info(currency)
    self.currency_list ||= []
    currency = Currency.find(:first, conditions: {currency_id: currency.currency_id})
    currency_information = CurrencyInformation.new
    currency_information.id = currency.currency_id
    currency_information.name = currency.name
    self.currency_list.push(currency_information)
  end

  def calculate_currency(currency_id)
    log_list = LogForCurrency.find(
      :all,
      conditions: {
        currency_id: currency_id,
        to_member_id: self.member_id
      }
    )
    amount = log_list.inject(0) do |sum, log|
      sum += log.amount
    end
    currency_information = self.currency_list.find{|saved_currency|
      saved_currency.id == currency_id
    }
    currency_information.amount = amount
  end

  class CurrencyInformation
    attr_accessor :id
    attr_accessor :name
    attr_accessor :amount
  end
end
