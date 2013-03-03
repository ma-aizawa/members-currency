module ApplicationHelper
  def login_member_name
    login_member.name
  end

  def login_member
    member_id = session[:login]
    Member.find(:first, conditions: {member_id: member_id})
  end

  def control_group_class(form, field)
    group = "control-group"
    return group if form.object.errors[field].blank?
    "#{group} error"
  end

  def error_message(model_object, field)
    return if model_object.errors[field].blank?

    field_name = t(".#{field.to_s}")
    error_message = model_object.errors[field].first
    <<-ERROR.html_safe
    <span class="help-inline">#{field_name}#{error_message}</span>
    ERROR
  end
end

