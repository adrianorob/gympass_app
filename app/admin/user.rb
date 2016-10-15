ActiveAdmin.register User do

  index do
    selectable_column
    column :id
    column :email
    column :admin
    column :name
    column :created_at
    column :type_user
    column :work_address
    column :home_address
    actions
  end


  form do |f|
    f.inputs "Identity" do
      f.input :name
      f.input :email
      f.input :type_user
      f.input :work_address
      f.input :home_address
    end
    f.inputs "Admin" do
      f.input :admin
    end
    f.actions
  end

  permit_params :name, :email, :admin, :type_user, :work_address, :home_address
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
