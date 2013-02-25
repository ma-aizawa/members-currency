
5.times do |n|
  Member.create(id: n, name: "Member#{n}", profile: "The number of #{n} member!")
end
