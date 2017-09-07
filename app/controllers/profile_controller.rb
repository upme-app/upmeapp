class ProfileController < ApplicationController

  def my_profile

  end

  def save_profile
    if current_user.update_attributes(user_params)
      flash[:success] = 'Perfil salvo!'
      redirect_to my_profile_path
    else
      flash[:danger] = 'Não conseguimos salvar suas informações.'
      redirect_to :back
    end
  end

  def update_picture
    picture_address = "./tmp/#{current_user.id}-tmp-profile-pic.png"
    IO.copy_stream(params['file'], picture_address)

    uuid = SecureRandom.uuid

    new_url = "https://s3-sa-east-1.amazonaws.com/#{ENV['S3_BUCKET_NAME']}/user-profile-pictures/#{uuid}"
    obj = S3_BUCKET.object("user-profile-pictures/#{uuid}")
    upload = obj.upload_file(picture_address)

    File.delete(picture_address)

    if upload
      current_user.update_attribute :profilepicurl, new_url
      render json: current_user.profilepicurl
    else
      render json: :error
    end

  end

  private

  def user_params
    params.require(:user).permit(:linkedin, :email, :universidade, :semestre, :phone, :city, :about)
  end

end
