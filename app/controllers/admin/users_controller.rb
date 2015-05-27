class Admin::UsersController < Admin::RestfullController
  def attrs_for_index
    [:email, :name]
  end

  def attrs_for_form
    [:email, :name, :roles]
  end

  def permitted_for_form
    [:email, :name , role_ids: []]
  end
end
