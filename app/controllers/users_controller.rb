class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize! :read, User, :message => 'Need to be a member'
  end

  def update
    authorize! :update, User, :message => 'You need to be an administrator to do that'
    @user = User.find(params[:id])
    role = params[:user][:role] unless params[:user][:role].nil?
    params[:user] = params[:user].except(:role)
    if @user.update_attributes(params[:user])
      @user.update_plan(role) unless role.nil?
      redirect_to user_path, :notice => "User updated."
    else
      redirect_to user_path, :alert => "Unable to update user."
    end
  end
end