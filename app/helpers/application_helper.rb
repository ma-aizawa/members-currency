module ApplicationHelper
  def login_member_name
    "Login: #{login_member.name}"
  end

  def login_member
    member_id = session[:login]
    Member.find(:first, conditions: {member_id: member_id})
  end
end
