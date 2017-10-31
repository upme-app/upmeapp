class VisitorsController < ApplicationController

  def landing_page

    end

  def post_newsletter
    landing = LandingQuiz.new({
                                  quem: params[:quem],
                                  curso: params[:curso],
                                  email: params[:email]
                              })
    if landing.save
      flash[:success] = 'Obrigada! Em breve mandamos notícias :)'
      Thread.new do
        LandingPageMailer.welcome_email(params[:email]).deliver
      end
      redirect_to root_path
    else
      flash[:error] = 'Email já utilizado.'
      redirect_to root_path
    end
  end

  def precos
  end

end
