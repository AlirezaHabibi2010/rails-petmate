class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.where(activated: true)
      else
        scope.where(user: user, activated: true)
      end
    end
  end

  class Scopeinbox < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.where(activated: true)
      else
        scope.where(activated: true).includes(:pet).where(pet: {user: user}).or(
          scope.where(activated: true).where(bookings: {user: user})
        )
      end
    end
  end

  def index?
    true
  end

  def show?
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

  def requests_list?
    true
  end

  def accepted?
    record.pet.user == user ||  user.admin?
  end

  def declined?
    record.pet.user == user ||  user.admin?
  end

  def ongoing?
    record.pet.user == user ||  user.admin?
  end

  def completed?
    record.pet.user == user ||  user.admin?
  end

  def confirmation?
    record.user == user ||  user.admin?
  end

  def chatroom?
    record.user == user || record.pet.user == user ||  user.admin? 
  end

  def inbox?
    true
  end

  def deactivate?
    record.user == user ||  user.admin?
  end
end
