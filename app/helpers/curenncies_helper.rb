module CurennciesHelper
  def currency_distribution_with_unit(currency)
    "#{number_with_delimiter(currency.distribution)} #{currency.unit}"
  end

  def publisher?(currency_id)
    currency = Currency.get(currency_id)
    login_member.member_id == currency.publisher
  end

  def get_member_list
    Member.all.map {|member|
      <<-TAG
      <option value="#{member.member_id}">#{member.name}</option>
      TAG
    }.join("\n").html_safe
  end
end

