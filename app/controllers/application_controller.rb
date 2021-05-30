# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def after_sign_in_path_for(_resource)
    books_path
  end

  def after_sign_up_path_for(_resouce)
    books_path
  end

  def after_sign_out_path_for(_resouce)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name self_introduction address postal_code])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name self_introduction address postal_code])
  end
end
