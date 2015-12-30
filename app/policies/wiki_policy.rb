class WikiPolicy < ApplicationPolicy
  
  attr_reader :user, :wiki
 
   def initialize(user, wiki)
    @user = user
    @wiki = wiki
   end
  
   class Scope < Scope

    def resolve
      if user.admin?
        scope.all # if the user is an admin, show them all the wikis
      else

        # scope.where(:user_id => user.collaborators.select(:wiki_id))
        
        t = Wiki.arel_table
        
        results = Wiki.where(
          t[:user_id].eq(user.collaborators.select(:user_id)).
          or(t[:private].eq(false)).
          or(t[:user_id].eq(user))
        )
        results
        # all_wikis = scope.all
        
        # ws = []
        
        # all_wikis.each do |w|
        #   if w.private == false || wiki.user == user || wiki.users.include?(user)
        #     ws << w.first # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
        #   end
        # end
        # ws = ws.to_a
        # wikis = ws
        # wikis
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
