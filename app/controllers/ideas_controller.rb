class IdeasController < ApplicationController
    # http://blog.remarkablelabs.com/2013/01/how-to-decrease-coupling-in-your-controllers-views-with-decent_exposure-for-better-maintainability
    respond_to :html
    expose :idea, attributes: :idea_params
    expose :ideas

    
    def create
        if idea.save
          flash[:notice] = I18n.t("flash.New idea success")
        else
          flash[:notice] = I18n.t("flash.New idea missing fields")
        end
        respond_with(idea)
    end
    
    
    private

    params_for :idea, :title, :body
end