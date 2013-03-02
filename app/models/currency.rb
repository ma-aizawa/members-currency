class Currency < ActiveRecord::Base
  attr_accessible :currency_id, :name, :publisher, :unit

  class << self
    def get(currency_id)
      Currency.find(:first, conditions: {currency_id: currency_id})
    end
  end

  def distribution
    distributed_currency = LogForCurrency.find(:all, conditions: {currency_id: self.currency_id})
    distributed_currency.inject(0) do |sum, log|
      sum += log.amount
    end
  end

  def publisher_name
    Member.find(:first, conditions: {member_id: self.publisher}).name
  end
end

