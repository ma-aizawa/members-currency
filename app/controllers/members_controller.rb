class MembersController < ApplicationController

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(:first, conditions: {id: params[:id]})
    currency_list = Currency.all
    currency_list.each do |currency|
      @member.set_currency_info(currency)
    end
  end

  def new
    @member = Member.new
  end

  def create
    member = Member.new.load_data(params[:member])
    member.generate_member_id

    if member.invalid?
      @member = member
      flash.now[:error] = t('message.invalid_message')
      render :new and return
    end

    member.save
    redirect_to member
  end


  def destroy
    primary_key = params[:id]
    member = Member.find(:first, conditions: {id: primary_key})

    unless member.deletable?
      logger.warn "Illegal access! Delete #{member.name}."
      flash[:error] = "Illegal operation!! Use normally."
      redirect_to members_path and return
    end

    logger.info "Delete #{member.name} of member."
    member.delete
    redirect_to members_path
  end

  def login
    member_id = params[:member_id]
    login_member = Member.get(member_id)
    save_login(login_member.member_id)

    redirect_to members_path
  end

  def logout
    reset_by_logout
    redirect_to members_path
  end

  def confirm_to_give
    @currency = Currency.get(params[:currency_id])
    @to_member = Member.get(params[:to_id])
    @from_member = Member.get(params[:from_id])

    @to_member.set_currency_info(@currency)
    @from_member.set_currency_info(@currency)
  end

  def give
    currency = Currency.get(params[:currency_id])
    to_member = Member.get(params[:to_id])
    from_member = Member.get(params[:from_id])
    given_amount = params[:given_amount]

    from_member.give(given_amount, currency).to(to_member).run

    redirect_to member_path(to_member.id)
  end
end

