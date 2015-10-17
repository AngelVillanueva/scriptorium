class IdeasController < ApplicationController
    # http://blog.remarkablelabs.com/2013/01/how-to-decrease-coupling-in-your-controllers-views-with-decent_exposure-for-better-maintainability
    respond_to :html
    expose :idea, attributes: :idea_params

    
    def create
        flash[:notice] = "The new idea was created successfully" if idea.save
        respond_with(idea)
    end
    
    
    private

    params_for :idea, :title, :body
end