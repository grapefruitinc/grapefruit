class CustomRegistrationController < Devise::RegistrationsController

  def create
    super
    if resource.persisted? # user is created successfully
      school_name = params[:school_typeahead]
      school_account = SchoolAccount.where(name: school_name).first_or_create()
      resource.school_account = school_account
      resource.save
    end
  end

end
