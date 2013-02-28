
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

100.times do |n|
  from_member_id = (n + n**2) % 5
  to_member_id = n % 5
  currency_id = n % 3
  minus = (n % 13).zero? ? -1 : 1
  time = DateTime.current
  LogForCurrency.create(
    currency_id: currency_id,
    amount: n**2 * minus,
    log: "Operation #{n}",
    from_member_id: from_member_id,
    to_member_id: to_member_id,
    operation_date: time
  )
end

