class ProjectUploadsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_project

  def index

  end

  def download
    redirect_to S3_BUCKET.object("project-uploads/#{@project.id}/#{params[:file_name]}.#{params[:ext]}").presigned_url(:get, expires_in: 60, response_content_disposition: "attachment;")
  end
  
  def upload
    filename = params['file'].original_filename
    
    if ProjectUpload.where(file: filename, project_id: @project.id).size > 0
      flash[:danger] = 'Arquivo já existe.'
      redirect_to project_uploads_path(@project.id)
      return
    end

    address = "./tmp/#{current_user.id}-#{filename}"
    IO.copy_stream(params['file'], address)

    obj = S3_BUCKET.object("project-uploads/#{@project.id}/#{filename}")
    upload = obj.upload_file(address)

    if upload
      ProjectUpload.create({project_id: @project.id, file: filename})
      redirect_to project_uploads_path(@project.id)
    else
      render json: :error
    end
  end

  def delete
    filename = "#{params[:file_name]}.#{params[:ext]}"
    if ProjectUpload.where(file: filename, project_id: @project.id).size > 0
      ProjectUpload.where(file: filename, project_id: @project.id).destroy_all 
      S3_BUCKET.object("project-uploads/#{@project.id}/#{filename}").delete
      flash[:notice] = 'Arquivo excluído!' 
    else
      flash[:danger] = 'Arquivo não existe.'
    end
    redirect_to project_uploads_path(@project.id)
  end

  def set_project
    @project = Project.find(params[:id])
  end
  
  def authorize_project
    set_project
    unless @project.has_user(current_user)
      flash[:danger] = 'Você não pode acessar essa página'
      redirect_to public_project_path(@project.id)
    end
  end

end
