module ApplicationHelper

  def current_controller?(name)
    controller_name == name
  end

  def row_number(index, limit_value)
    row_number = index + 1 + (params[:page].nil? ? 0 : params[:page].to_i * limit_value - limit_value)
  end

end
