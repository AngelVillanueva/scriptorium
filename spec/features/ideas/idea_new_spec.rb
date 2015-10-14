include Warden::Test::Helpers
Warden.test_mode!

# Feature: Idea creation
#   As a user
#   I want to create a new idea
#   So I can use it as the seed for a future story
feature 'Idea creation', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User creates Idea
  #   Given I am signed in
  #   When I create a new Idea
  #   Then I see the new Idea in my workspace
  scenario 'user creates new idea' do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit user_path(user)
      click_link 'New Idea'
      fill_in 'Title', :with => "My next great Idea"
      fill_in 'Text', :with => "What if Don Quixote was a woman?"
      click_button 'Create'
      idea = Idea.last
      expect(page).to have_content idea.title
  end
  
end