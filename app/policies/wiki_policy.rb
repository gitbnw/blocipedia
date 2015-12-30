class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

   def initialize(user, wiki)
    @user = user
    @wiki = wiki
   end

   class Scope < Scope



     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.public? || wiki.user == user || wiki.users.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.public? || wiki.users.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
       #raise wikis.inspect
     end

        # ws = ws.to_a
        # wikis = ws
        # wikis
      # end

    # end

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
