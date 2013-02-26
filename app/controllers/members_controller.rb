class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(:first, conditions: {member_id: params[:id]})
  end
end
