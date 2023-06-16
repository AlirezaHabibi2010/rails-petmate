class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # user.admin? ? scope.all : scope.where(user: user)
      scope.all
    end
  end

  def create?
    record.booking.user == user ||  user.admin?
  end

  def update?
    record.user == user ||  user.admin?
  end

  def destroy?
    record.user == user ||  user.admin?
  end

end
