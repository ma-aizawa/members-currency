class LogForCurrency < ActiveRecord::Base
  attr_accessible :currency_id    # Relation to target currency
  attr_accessible :amount         # Amount of operation
  attr_accessible :log            # Description of operation
  attr_accessible :from_member_id # Member operated currency
  attr_accessible :to_member_id   # Member is operated currency
  attr_accessible :operation_date # Datetime at operating

  def currency_name
    currency.name
  end

  def unit
    currency.unit
  end

  def from_member_name
    member_name(self.from_member_id)
  end

  def to_member_name
    member_name(self.to_member_id)
  end

  private
  def currency
    @currency ||= Currency.find(:first, conditions: {currency_id: self.currency_id})
  end

  def member_name(member_id)
    Member.get(member_id).name
  end
end

