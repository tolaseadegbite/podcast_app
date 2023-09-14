class ApplicationController < ActionController::Base

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :firstname, :lastname, :bio, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :firstname, :lastname, :bio, :avatar])
    end
end
