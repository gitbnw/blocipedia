class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
 
   def initialize(user, wiki)
    @user = user
    @wiki = wiki
   end
  
   class Scope < Scope

    def resolve
      if user.admin? || user.premium?
        scope.all
      else
        scope.where(:private => false)
      end
      
    end
  
  end


  def index?
    scope.where(id: wiki.id).exists?
  end

  def show?
    user.admin? || user.premium? or not wiki.private?
  end

  def create?
    user.admin? || user.premium? or not wiki.private?
  end

  def new?
    create?
  end

  def update?
    user.admin? || user.premium? or not wiki.private?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin? || user.premium? or not wiki.private?
  end



end
