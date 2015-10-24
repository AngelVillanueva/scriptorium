class IdeaPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end
  
  def show?
    @current_user.admin? or @current_user == @model.user
  end

end
