module CurennciesHelper
  def currency_distribution_with_unit(currency)
    "#{number_with_delimiter(currency.distribution)} #{currency.unit}"
  end
end
