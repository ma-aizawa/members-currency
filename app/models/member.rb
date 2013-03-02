class Member < ActiveRecord::Base
  attr_accessible :member_id, :name, :profile
  attr_accessor :currency_list

  class << self
    def get(member_id)
      Member.find(:first, conditions: {member_id: member_id})
    end
  end

  def set_currency_info(currency)
    self.currency_list ||= []
    currency_id = currency.currency_id
    currency_information = CurrencyInformation.new
    currency_information.id = currency_id
    currency_information.name = currency.name
    currency_information.amount = AmountOfCurrency.get(self.member_id, currency_id).amount
    self.currency_list.push(currency_information)
  end

  class CurrencyInformation
    attr_accessor :id
    attr_accessor :name
    attr_accessor :amount
  end

end

