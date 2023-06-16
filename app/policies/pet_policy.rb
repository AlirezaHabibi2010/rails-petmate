class PetPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # user.admin? ? scope.all : scope.where(user: user)
      scope.where(activated: true)
    end
  end

  class ScopeList < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.admin? ? scope.all.where(activated: true) : scope.where(user: user).where(activated: true)
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def list?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user ||  user.admin?
  end

  def destroy?
    record.user == user ||  user.admin?
  end

  def deactivate?
    record.user == user ||  user.admin? 
  end

  def owner_requests_list?
    true
  end
end
