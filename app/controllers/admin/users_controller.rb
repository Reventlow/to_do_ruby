class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    # @users is automatically loaded by CanCanCan
  end

  # GET /admin/users/:id
  def show
    # @user is automatically loaded by CanCanCan
  end

  # GET /admin/users/new
  def new
    # @user is automatically loaded by CanCanCan
  end

  # GET /admin/users/:id/edit
  def edit
    # @user is automatically loaded by CanCanCan
  end

  # POST /admin/users
  def create
    # @user is built by CanCanCan with user_params
    if @user.save
      redirect_to admin_user_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/:id
  def update
    # @user is automatically loaded by CanCanCan and updated with user_params
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/users/:id
  def destroy
    # @user is automatically loaded by CanCanCan
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    # CanCanCan's load_and_authorize_resource method makes this redundant for most actions,
    # but it's useful if you need to do additional setup or constraints.
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
