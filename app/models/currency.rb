class Currency < ActiveRecord::Base
  attr_accessible :currency_id, :name, :publisher, :unit

  validates :name, presence: true, length: {maximum: 255}
  validates :unit, presence: true, length: {maximum: 50}

  class << self
    def get(currency_id)
      self.class.find(:first, conditions: {currency_id: currency_id})
    end
  end

  def load_data(params)
    self.name = params[:name]
    self.unit = params[:unit]
    self
  end

  def set_publisher(member_id)
    self.publisher = member_id
    self
  end

  def generate_currency_id
    self.currency_id = self.class.all.max{|a, b| a.currency_id <=> b.currency_id}.currency_id + 1
    self
  end

  def distribution
    distributed_currency = LogForCurrency.find(:all, conditions: {currency_id: self.currency_id})
    distributed_currency.inject(0) do |sum, log|
      sum += log.amount
    end
  end

  def publisher_name
    Member.get(self.publisher).name
  end

  def add(amount)
    add_amount = AmountChange.new(:add, amount)
    add_amount
  end

  class AmountChange
    attr_accessor :type, :amount, :currency, :publisher, :members, :amount_per_member

    def initialize(type, amount)
      self.type = type
      self.amount = amount
    end

    def of(currency)
      self.currency = currency
      self
    end

    def to(members)
      self.members = members
      self
    end

    def per(amount_per_member)
      self.amount_per_member = amount_per_member
      self
    end

    def by(publisher)
      self.publisher = publisher
      self
    end

    def run
      self.members.each_with_index do |member_id, index|
        member = Member.get(member_id)
        member_amount = self.amount_per_member[index]
        register_log(member, member_amount)
        add_amount_to_member(member, member_amount)
      end

      true
    end

    private
    def add_amount_to_member(to_member, member_amount)
      amount_of_currency = AmountOfCurrency.get(to_member.member_id, currency.currency_id)
      amount_of_currency.amount += member_amount.to_i

      amount_of_currency.save
    end

    def register_log(member, member_amount)
      log = LogForCurrency.new
      log.currency_id = self.currency.currency_id
      log.from_member_id = LogForCurrency::SYSTEM_ID
      log.to_member_id = member.member_id
      log.amount = member_amount.to_i
      log.operation_date = DateTime.current
      log.log = operation_log(member)

      log.save
    end

    def operation_log(member = nil)
      case self.type
      when :add
        "#{self.publisher.name} add amount of #{self.currency.name}. Distribute to #{member.name}."
      end
    end
  end
end

