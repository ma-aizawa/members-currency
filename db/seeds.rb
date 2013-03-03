
5.times do |n|
  if Member.where(member_id: n).empty?
    Member.create(member_id: n, name: "Member#{n}", profile: "The number of #{n} member!")
  end
end

3.times do |n|
  if Currency.where(currency_id: n).empty?
    Currency.create(currency_id: n, name: "Currency#{n}", publisher:n, unit: "unit#{n}")
  end
end

90.times do |n|
  to_member_id = n % 5
  currency_id = n % 3
  minus = (n % 13).zero? ? -1 : 1
  time = DateTime.current
  LogForCurrency.create(
    currency_id: currency_id,
    amount: n**2 * minus,
    log: "Operation #{n}",
    from_member_id: LogForCurrency::SYSTEM_ID,
    to_member_id: to_member_id,
    operation_date: time
  )
end

10.times do |n|
  from_id = n**2 % 5
  from_name = Member.get(from_id).name
  to_id = n % 5
  to_name = Member.get(to_id).name
  currency_id = n % 3
  currency_name = Currency.get(currency_id).name
  amount = n**2
  time = DateTime.current

  LogForCurrency.create(
    currency_id: currency_id,
    amount: amount,
    log: "#{from_name} give #{currency_name} to #{to_name}",
    from_member_id: from_id,
    to_member_id: to_id,
    operation_date: time
  )
end

Member.all.each do |member|
  Currency.all.each do |currency|
    amount = LogForCurrency.find(
      :all,
      conditions: {
        currency_id: currency.currency_id,
        to_member_id: member.member_id
      }
    ).inject(0) {|sum, log|
      sum += log.amount
    }
    amount -= LogForCurrency.find(
      :all,
      conditions: {
        currency_id: currency.currency_id,
        from_member_id: member.member_id
      }
    ).inject(0) {|sum, log|
      sum += log.amount
    }
    AmountOfCurrency.create(
      member_id: member.member_id,
      currency_id: currency.currency_id,
      amount: amount
    )
  end
end

100.times do |n|
  MoneyTicket.create(
    ticket_id: n,
    currency_id: -1,
    amount: 500,
    status: MoneyTicket::NO_USE
  )
end
