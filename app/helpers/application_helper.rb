module ApplicationHelper
  def login_member_name
    member_id = session[:login]
    member_name = Member.find(:first, conditions: {member_id: member_id}).name
    "Login: #{member_name}"
  end
end
