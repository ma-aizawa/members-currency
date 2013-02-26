class LogForCurrency < ActiveRecord::Base
  attr_accessible :amount, :currency, :currency_id, :log
end
