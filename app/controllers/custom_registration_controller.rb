class CustomRegistrationController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    # Setting school on the resource
    school_name = params[:school_typeahead]
    school_account = SchoolAccount.where(name: school_name).first
    resource.school_account = school_account

    resource_saved = resource.save
    yield resource if block_given?

    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

end
