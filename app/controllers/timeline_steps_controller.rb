class TimelineStepsController < ApplicationController
  before_action :set_timeline_step, only: [:show, :edit, :update, :destroy]

  # GET /timeline_steps
  # GET /timeline_steps.json
  def index
    @timeline_steps = TimelineStep.where(user_id:current_user.id)
  end

  # GET /timeline_steps/1
  # GET /timeline_steps/1.json
  def show
  end

  # GET /timeline_steps/new
  def new
    @project = Project.find(params[:project_id])
    @timeline_step = TimelineStep.new
  end

  # GET /timeline_steps/1/edit
  def edit
    @project = Project.find(params[:project_id])
  end

  def reorder
    @lista = TimelineStep.where(:project_id => params[:project_id]).order('position asc')
    @project = Project.find(params[:project_id])
  end

  def sort
    params[:timeline_step].each_with_index do |id, index|
      #TimelineStep.update_all({position: index+1}, {id: id})
      TimelineStep.where(id: id).update_all(position: index+1)
    end
    render nothing: true
  end

  # POST /timeline_steps
  # POST /timeline_steps.json
  def create
    @timeline_step = TimelineStep.new(timeline_step_params)

    respond_to do |format|
      if @timeline_step.save
        format.html { redirect_to project_path @timeline_step.project_id, notice: 'Passo da Linha do Tempo foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @timeline_step }
      else
        format.html { render :new }
        format.json { render json: @timeline_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timeline_steps/1
  # PATCH/PUT /timeline_steps/1.json
  def update
    respond_to do |format|
      if @timeline_step.update(timeline_step_params)
        format.html { redirect_to project_path, notice: 'Passo da Linha do Tempo foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @timeline_step }
      else
        format.html { render :edit }
        format.json { render json: @timeline_step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timeline_steps/1
  # DELETE /timeline_steps/1.json
  def destroy
    @timeline_step.destroy
    respond_to do |format|
      format.html { redirect_to timeline_steps_url, notice: 'Passo da Linha do Tempo foi excluido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeline_step
      @timeline_step = TimelineStep.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeline_step_params
      params.require(:timeline_step).permit(:project_id, :entregavel, :title, :description, :check_date, :entrega, :position, :feedback)
    end
end
