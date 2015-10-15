class IdeasController < ApplicationController
    def new
        @idea = Idea.new
    end
    def create
        @idea = Idea.new(secure_params[:idea])

        if @idea.save
            redirect_to @idea, notice: 'Idea was successfully created.'
        else
            render action: "new"
        end
    end
    def show
        @idea = Idea.find(params[:id])
    end
    
    private

    def secure_params
        params.require(:idea).permit(:title, :body)
    end
end