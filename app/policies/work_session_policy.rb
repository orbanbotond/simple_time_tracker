class WorkSessionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    true
  end

  def update?
    user.has_role? :admin || record.work_day.user == user
  end

  def destroy?
    user.has_role? :admin || record.work_day.user == user
  end

  def show?
    true
  end
end
