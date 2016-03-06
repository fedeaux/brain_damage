class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  def index
    @areas = Area.all
  end

  # GET /areas/1
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  def create
    @area = Area.new(area_params)

    if @area.save
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @area, notice: 'Area was successfully created.'
        }
      end

    else
      render :new
    end
  end

  # PATCH/PUT /areas/1
  def update
    if @area.update(area_params)
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @area, notice: 'Area was successfully updated.'
        }
      end

    else
      render :edit
    end
  end

  # DELETE /areas/1
  def destroy
    @area.destroy

    respond_to do |format|
      format.json {
        render :nothing => true, :status => 200
      }

      format.html {
        redirect_to areas_url, notice: 'Area was successfully destroyed.'
      }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def area_params
      params.require(:area).permit(:name, :description)
    end
end
