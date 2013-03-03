module MoneyTicketsHelper
  def currency_options(currencies)
    currencies.map {|currency|
      <<-TAG
      <option value="#{currency.currency_id}">#{currency.name}</option>
      TAG
    }.join("\n").html_safe
  end

  def ticket_amount_all(tickets)
    tickets.inject(0) do |sum, ticket|
      sum + ticket.amount
    end
  end

  def ticket_amount_no_use(tickets)
    tickets.inject(0) do |sum, ticket|
      if ticket.status == MoneyTicket::NO_USE
        sum + ticket.amount
      else
        sum
      end
    end
  end

  def ticket_amount_exchanged(tickets)
    tickets.inject(0) do |sum, ticket|
      if ticket.status == MoneyTicket::USED
        sum + ticket.amount
      else
        sum
      end
    end
  end

  def ticket_register?(member)
    return false unless Currency.find(:first, conditions: {publisher: member.member_id})
    true
  end
end

