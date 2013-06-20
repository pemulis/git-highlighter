class RecommendationsController < ApplicationController
  def show
  end

  def destroy
    if @rec = Recommendation.find(params[:id])
      @rec.hidden = true
      redirect_to root_url
    end
  end
end
