class Admin::UsersController < Admin::RestfullController
  def attrs_for_index
    [:email, :name]
  end

  def attrs_for_form
    [:email, :name]
  end
end
