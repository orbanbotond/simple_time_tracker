class Admin::WorkDaysController < Admin::RestfullController

  helper_method :user

  def destroy
    destroy! { admin_user_work_days_path user }
  end

  def create
    create! { admin_user_work_days_path user }
  end

  def new
    build_resource.work_sessions.build
    new!
  end

  def edit
    resource.work_sessions.build
    edit!
  end

  def update
    update! { admin_user_work_days_path user }
  end


  def attrs_for_index
    [:date]
  end

  def attrs_for_form
    [:date]
  end

  def user
    User.find(params[:user_id])
  end

  protected

  def begin_of_association_chain
    user
  end

  def permitted_params
    resource = resource_class.to_s.underscore.downcase.to_sym
    {resource => params.fetch(resource, {}).permit(:date, work_sessions_attributes:[:description, :start_time, :end_time, :id, :_destroy])}
  end

end
