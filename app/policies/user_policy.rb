class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    user.has_role? :admin
  end

  def update?
    user.has_role? :admin
  end

  def show?
    true
  end
end
