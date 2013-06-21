class RecommendationsController < ApplicationController
  def show
  end

  def destroy
    if @rec = Recommendation.find(params[:id])
      @rec.hidden = true
      
      respond_to do |format|
        if @rec.save
          format.html { redirect_to root_url }
          format.js {}
          format.json { render json: @rec, status: :hidden }
        else
          format.html { redirect_to root_url }
          format.json { render json: @rec.errors, status: :not_hidden }
        end
      end
    end
  end
end
