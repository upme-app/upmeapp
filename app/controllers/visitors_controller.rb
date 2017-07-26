class VisitorsController < ApplicationController

  def landing_page

  end

  def save_quiz
    landing = LandingQuiz.new({
      quem: params[:quem],
      curso: params[:curso],
      email: params[:email]
    })

    if landing.save
      render json: :success
    else
      render json: :error
    end
  end

end
