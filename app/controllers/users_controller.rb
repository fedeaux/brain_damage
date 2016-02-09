class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @user, notice: 'User was successfully created.'
        }
      end

    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @user, notice: 'User was successfully updated.'
        }
      end

    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    respond_to do |format|
      format.json {
        render :nothing => true, :status => 200
      }

      format.html {
        redirect_to users_url, notice: 'User was successfully destroyed.'
      }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name)
    end
end
