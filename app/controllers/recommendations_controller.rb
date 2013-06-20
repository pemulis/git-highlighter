class RecommendationsController < ApplicationController
  def show
  end

  def destroy
    Recommendation.destroy(params[:id])
    redirect_to root_url
  end
end
