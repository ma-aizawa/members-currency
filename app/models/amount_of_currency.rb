class AmountOfCurrency < ActiveRecord::Base
  attr_accessible :amount, :currency_id, :member_id

  class << self
    def get(member_id, currency_id)
      AmountOfCurrency.find(
        :first,
        conditions: {
          currency_id: currency_id,
          member_id: member_id
        }
      )
    end
  end
end

