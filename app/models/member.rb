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
    currency = Currency.get(currency.currency_id)
    currency_information = CurrencyInformation.new
    currency_information.id = currency.currency_id
    currency_information.name = currency.name
    self.currency_list.push(currency_information)
    self
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
    self
  end

  def currency_amount(currency_id)
    currency_info = currency_list.find{|currency| currency.id == currency_id}
    currency_info.amount
  end

  def give(given_amount, currency)
    operation = CurrencyOperation.new(self, :give)
    operation.target_currency(currency)
    operation.set_amount(given_amount)
    operation
  end

  class CurrencyInformation
    attr_accessor :id
    attr_accessor :name
    attr_accessor :amount
  end

  class CurrencyOperation
    attr_accessor :type, :from, :currency, :to_member, :amount

    def initialize(from_member, type)
      self.from = from_member
      self.type = type
    end

    def target_currency(currency)
      self.currency = currency
    end

    def set_amount(amount)
      self.amount = amount
    end

    def to(member)
      self.to_member = member
      self
    end

    def run
      log = LogForCurrency.new
      log.currency_id = self.currency.currency_id
      log.from_member_id = self.from.member_id
      log.to_member_id = self.to_member.member_id
      log.amount = self.amount
      log.operation_date = DateTime.current
      log.log = operation_log

      log.save

      true
    end

    def operation_log
      case self.type
      when :give
        "#{from.name} give #{currency.name} to #{to_member.name}"
      end
    end
  end
end

