
5.times do |n|
  if Member.where(member_id: n).empty?
    Member.create(member_id: n, name: "Member#{n}", profile: "The number of #{n} member!")
  end
end

3.times do |n|
  if Currency.where(currency_id: n).empty?
    Currency.create(currency_id: n, name: "Currency#{n}", publisher:n)
  end
end
