class MoneyTicket < ActiveRecord::Base
  attr_accessible :amount, :currency_id, :ticket_id, :status, :used_date

  NO_USE = 'NO_USE'
  USED = 'USED'

  def get_status
    case self.status
    when NO_USE
      'No used'
    when USED
      'Used'
    end
  end

  def get_used_date
    return '-' if self.used_date.nil?
    self.used_date
  end
end

