include Warden::Test::Helpers
Warden.test_mode!

# Feature: Idea index
#   As a user
#   I want to see all my ideas
#   So I can choose one as the seed for a future story

feature 'Idea index', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees her Ideas
  #   Given I am signed in
  #   When I visit My Ideas page
  #   Then I see all my Ideas
  scenario 'user sees all her ideas' do
      user = FactoryGirl.create(:user)
      3.times do |index|
        FactoryGirl.create(:idea, title: "My great Idea number #{index}", user: user)
      end
      login_as(user, :scope => :user)
      visit user_path(user)
      click_link I18n.t("My Ideas")
      expect(page).to have_content(I18n.t("My Ideas"))
      expect(page).to have_selector("li.idea", count: 3)
      expect(page).to have_content("My great Idea number 2")
  end
  # Scenario: User cannot see other's Ideas in her Ideas page
  #   Given I am signed in
  #   When I visit My Ideas page
  #   Then I see just my Ideas
  #   And  I cannot see Ideas coming from another Writer
  scenario 'users cannot see ideas from other writers in her Ideas page' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: "user2@example.com")
    idea = FactoryGirl.create(:idea, user: user2)
    login_as(user1, :scope => :user)
    visit user_ideas_path(user1)
    expect(page).to_not have_selector("li.idea")
  end
  # Scenario: User cannot access other writer's Ideas page
  #   Given I am signed in
  #   When I visit other Writer's Ideas page
  #   Then I cannot access that page
  scenario 'users cannot access other writer Ideas page' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: "test2@example.com")
    login_as(user1, :scope => :user)
    visit user_ideas_path(user2)
    expect(page).to have_content("Access denied")
  end
  # Scenario: Admin can access other writer's Ideas page
  #   Given I am signed in
  #   When I visit other Writer's Ideas page
  #   Then I cannot access that page
  scenario 'users cannot access other writer Ideas page' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: "test2@example.com")
    login_as(user1, :scope => :user)
    visit user_ideas_path(user2)
    expect(page).to have_content("Access denied")
  end
  # Scenario: Admin can access the Idea page for her Ideas
  scenario 'admin can go to any Idea page from any Ideas index' do
    pending 'thinking about the behaviour to be tested'
  end
  # Scenario: the failed access to any Idea page shoud be gracefully recovered
  scenario 'unauthorized access to Idea page should be recovered' do
    pending 'thinking about the behaviour to be tested'
  end
  # Scenario: the Idea page is just accessible for its Writer
  #   Given I am signed in
  #   And another Writer has an Idea
  #   When I visit that Idea page
  #   Then I cannot access the Idea page
  scenario 'the page of other writer idea cannot be accesed' do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:idea, user: user)
    user2 = FactoryGirl.create(:user, email: "test2@example.com")
    login_as(user2, :scope => :user)
    visit user_idea_path(user,idea)
    expect(page).to_not have_content(idea.body)
  end
end