ActiveAdmin.register User, as: "Unassigned Users" do

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
      User.unassigned
    end

    # So that you don't have to enter password when updating user
    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
      end

      super
    end
  end

  permit_params :email, :name, :password

  menu priority: 10

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :name
      f.input :password
    end

    f.actions
  end

  index do
    selectable_column

    column :id
    column :name do |student|
      link_to student.name, admin_student_path(student)
    end
    column :email
    column :sign_in_count

    actions
  end

end
