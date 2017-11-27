class ProjectEventsController < ApplicationController
  before_action :set_project_event, only: [:show, :edit, :update, :destroy]

  # GET /project_events
  # GET /project_events.json
  def index
    @project_events = ProjectEvent.where(user_id:current_user.id)
  end

  # GET /project_events/1
  # GET /project_events/1.json
  def show
  end

  # GET /project_events/new
  def new
    @project_event = ProjectEvent.new
  end

  # GET /project_events/1/edit
  def edit
  end

  # POST /project_events
  # POST /project_events.json
  def create
    @project_event = ProjectEvent.new(project_event_params)

    respond_to do |format|
      if @project_event.save
        format.html { redirect_to @project_event, notice: 'Project event was successfully created.' }
        format.json { render :show, status: :created, location: @project_event }
      else
        format.html { render :new }
        format.json { render json: @project_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_events/1
  # PATCH/PUT /project_events/1.json
  def update
    respond_to do |format|
      if @project_event.update(project_event_params)
        format.html { redirect_to @project_event, notice: 'Project event was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_event }
      else
        format.html { render :edit }
        format.json { render json: @project_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_events/1
  # DELETE /project_events/1.json
  def destroy
    @project_event.destroy
    respond_to do |format|
      format.html { redirect_to project_events_url, notice: 'Project event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_event
      @project_event = ProjectEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_event_params
      params.require(:project_event).permit(:project_id, :user_id, :title, :description, :start_date, :end_date)
    end
end
