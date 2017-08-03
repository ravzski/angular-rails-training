module PermissionChecker
  extend ActiveSupport::Concern

  def validate_permission module_code,action
    return true if current_user.super_admin
    permission = Permission.user_permissions.where("users.id = ? and permissions.code = ?", current_user.id, module_code)[0]
    if permission.present?
      permission.actions.include?action
    else
      false
    end
  end

end
