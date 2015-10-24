class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? or @current_user == @model
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    return false if @current_user == @model
    @current_user.admin?
  end
  
  def show_ideas?
    @current_user.id == @model.id
  end

end
