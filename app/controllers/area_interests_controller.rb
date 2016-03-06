class AreaInterestsController < ApplicationController
  before_action :set_area_interest, only: [:show, :edit, :update, :destroy]

  # GET /area_interests
  def index
    @area_interests = AreaInterest.all
  end

  # GET /area_interests/1
  def show
  end

  # GET /area_interests/new
  def new
    @area_interest = AreaInterest.new
  end

  # GET /area_interests/1/edit
  def edit
  end

  # POST /area_interests
  def create
    @area_interest = AreaInterest.new(area_interest_params)

    if @area_interest.save
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @area_interest, notice: 'Area interest was successfully created.'
        }
      end

    else
      render :new
    end
  end

  # PATCH/PUT /area_interests/1
  def update
    if @area_interest.update(area_interest_params)
      respond_to do |format|
        format.json {
          render :json => { :html => render_to_string(:partial => 'table.item', :formats => [:html]) }
        }

        format.html {
          redirect_to @area_interest, notice: 'Area interest was successfully updated.'
        }
      end

    else
      render :edit
    end
  end

  # DELETE /area_interests/1
  def destroy
    @area_interest.destroy

    respond_to do |format|
      format.json {
        render :nothing => true, :status => 200
      }

      format.html {
        redirect_to area_interests_url, notice: 'Area interest was successfully destroyed.'
      }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area_interest
      @area_interest = AreaInterest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def area_interest_params
      params.require(:area_interest).permit(:area_id, :owner_id, :owner_type)
    end
end
