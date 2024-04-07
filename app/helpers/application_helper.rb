module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type.to_sym
    when :notice then "alert-info"
    when :alert then "alert-warning"
    when :error then "alert-danger"
    else "alert-primary"
    end
  end
end
