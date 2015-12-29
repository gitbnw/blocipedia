class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    current_user.standard!
    Wiki.where(user: current_user).update_all(private: false)
    redirect_to action: "show"
  end

end
