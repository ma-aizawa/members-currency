class PeopleController < ApplicationController
  def index
    @members = Member.all
  end
end
