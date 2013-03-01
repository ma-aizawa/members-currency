module MembersHelper
  def login_link(login_now, member)
    login_now ? 'Login' : link_to('Login', login_path(member.member_id))
  end
end

