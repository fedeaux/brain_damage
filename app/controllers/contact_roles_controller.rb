class ContactRolesController < ApplicationController
  before_action :set_contact_role, only: [:show, :edit, :update, :destroy]

  # GET /contact_roles
  def index
    @contact_roles = ContactRole.all
  end

  # GET /contact_roles/1
  def show
  end

  # GET /contact_roles/new
  def new
    @contact_role = ContactRole.new
  end

  # GET /contact_roles/1/edit
  def edit
  end

  # POST /contact_roles
  def create
    @contact_role = ContactRole.new(contact_role_params)

    if @contact_role.save
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @contact_role, notice: 'Contact role was successfully created.'
        }
      end

    else
      render :new
    end
  end

  # PATCH/PUT /contact_roles/1
  def update
    if @contact_role.update(contact_role_params)
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @contact_role, notice: 'Contact role was successfully updated.'
        }
      end

    else
      render :edit
    end
  end

  # DELETE /contact_roles/1
  def destroy
    @contact_role.destroy

    respond_to do |format|
      format.json {
        render :nothing => true, :status => 200
      }

      format.html {
        redirect_to contact_roles_url, notice: 'Contact role was successfully destroyed.'
      }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_role
      @contact_role = ContactRole.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_role_params
      params.require(:contact_role).permit(:name)
    end
end
