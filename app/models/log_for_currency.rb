class LogForCurrency < ActiveRecord::Base
  attr_accessible :currency_id    # Relation to target currency
  attr_accessible :amount         # Amount of operation
  attr_accessible :log            # Description of operation
  attr_accessible :from_member_id # Member operated currency
  attr_accessible :to_member_id   # Member is operated currency
  ### TODO: operation Add datetime
end
