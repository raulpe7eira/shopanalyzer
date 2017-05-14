class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from ActiveRecord::DeleteRestrictionError do
    redirect_back fallback_location: root_path, alert: 'messages.error.dependents'
  end

  rescue_from ActiveRecord::RecordNotFound do
    redirect_back fallback_location: root_path, alert: 'messages.error.notfound'
  end

  rescue_from StandardError::TypeError do
    redirect_back fallback_location: root_path, alert: 'messages.error.typefile'
  end
end
