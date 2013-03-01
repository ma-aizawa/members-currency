class MembersController < ApplicationController
  def index
    @login_now = login?
    @members = Member.all
  end

  def show
    @member = Member.find(:first, conditions: {id: params[:id]})
    currency_list = Currency.all
    currency_list.each do |currency|
      @member.set_currency_info(currency)
      @member.calculate_currency(currency.currency_id)
    end
  end

  def login
    member_id = params[:member_id]
    login_member = Member.find(:first, conditions: {member_id: member_id})
    save_login(login_member.member_id)

    redirect_to members_path
  end

  def logout
    reset_by_logout
    redirect_to members_path
  end
end

