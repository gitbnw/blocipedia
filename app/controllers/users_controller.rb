class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    current_user.standard!
    redirect_to action: "show"
  end

end
