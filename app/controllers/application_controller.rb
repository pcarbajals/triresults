class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
    if !request.accept || request.accept == '*/*'
      render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
    else
      render status:   :not_found,
             template: 'error_msg',
             locals:   { msg: "woops: cannot find race[#{params[:id]}]" }
    end
  end

  rescue_from ActionView::MissingTemplate do |exception|
    Rails.logger.warn exception
    render plain: "woops: we do not support that content-type[#{request.accept}]", status: :unsupported_media_type
  end

end
