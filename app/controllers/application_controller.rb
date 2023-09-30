class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname, :bio, :avatar, :cover_image])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :firstname, :lastname, :bio, :avatar, :cover_image])
    end
end
