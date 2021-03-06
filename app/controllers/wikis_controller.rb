class WikisController < ApplicationController
  
  before_action :authenticate_user!
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create

     @wiki = Wiki.new
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]
     @wiki.user_id = current_user.id
     
     authorize @wiki

     if @wiki.save
       @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators], @wiki.id)
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else

       flash.now[:alert] = "There was an error saving the Wiki. Please try again."
       render :new
     end
  end
   
  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

   def update
     @wiki = Wiki.find(params[:id])
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     
     @wiki.private = params[:wiki][:private]
     
     authorize @wiki
 
     if @wiki.save
       @wiki.collaborators = Collaborator.update_collaborators(params[:wiki][:collaborators], @wiki.id)         
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end
   def destroy
     @wiki = Wiki.find(params[:id])
     
     authorize @wiki
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end    
   
  private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  
end
