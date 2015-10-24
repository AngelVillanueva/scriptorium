describe IdeaPolicy do
  subject { IdeaPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:idea) { FactoryGirl.build_stubbed :idea, user: current_user }

  
  permissions :show? do
    it "prevents other users from seeing your ideas" do
      expect(subject).not_to permit(other_user, idea)
    end
    it "allows you to see your own ideas" do
      expect(subject).to permit(current_user, idea)
    end
    it "allows an admin to see any idea" do
      expect(subject).to permit(admin)
    end
  end

end
