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

  def delete_currency_link(currency)
    (@login_now and currency.deletable?(login_member.member_id)) ?
      link_to('Delete', currency, method: :delete, confirm: t('message.confirm_delete')) :
      '<span class="muted">Delete</span>'.html_safe
  end
end

