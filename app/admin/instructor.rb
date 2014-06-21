ActiveAdmin.register User, as: "Instructor" do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  controller do
    def scoped_collection
      User.instructors
    end

    # So that you don't have to enter password when updating user
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
      end

      super
    end
  end

  permit_params :email, :name, :password, :is_admin

  menu priority: 2

  index do
    selectable_column

    column :id
    column :name do |student|
      link_to student.name, admin_student_path(student)
    end
    column :email
    column :sign_in_count
    column :is_admin

    actions
  end

end
