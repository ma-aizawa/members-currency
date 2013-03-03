class MoneyTicket < ActiveRecord::Base
  attr_accessible :amount, :currency_id, :ticket_id, :status, :used_date, :expire_date

  NO_USE = 'NO_USE'
  USED = 'USED'

  class << self
    def exchange_tickets(amount)
      raise Exception.new('Invalid amount!!') if invalid_amount?(amount)

      no_use_tickets = MoneyTicket.find(
        :all,
        conditions: [
          'status = ? AND expire_date > ?',
          NO_USE, DateTime.current
        ],
        order: 'expire_date asc, amount desc'
      ).select{|ticket|
        ticket.amount < amount
      }

      to_use_tickets = no_use_tickets.select{|ticket|
        next if amount.zero?
        if amount - ticket.amount < 0
          next
        end
        amount -= ticket.amount
        true
      }
      raise Exception.new('Ticket is insufficient!!') unless amount.zero?
      to_use_tickets
    end

    def invalid_amount?(amount)
      amount % 500 != 0
    end
  end

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

