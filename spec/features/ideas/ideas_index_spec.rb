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
  # Scenario: User cannot see other's Ideas
  #   Given I am signed in
  #   When I visit My Ideas page
  #   Then I see just my Ideas
  #   And  I cannot see Ideas coming from another Writer
  scenario 'users cannot see ideas from other writers' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: "user2@example.com")
    idea = FactoryGirl.create(:idea, user: user2)
    login_as(user1, :scope => :user)
    visit ideas_path(user1)
    expect(page).to_not have_selector("li.idea")
  end
  # Scenario: User can access the Idea page for her Ideas
  #   Given I am signed in
  #   When I visit My Ideas page
  #   And I choose one of them to see in detail
  #   Then I see the Idea page
  scenario 'users can go to an Idea page from the Ideas index' do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:idea, user: user)
    login_as(user, :scope => :user)
    visit ideas_path(user)
    click_link idea.title
    expect(page).to have_content(idea.title)
    expect(page).to have_content(idea.body)
  end
  # Scenario: the Idea page is just accessible for its Writer
  #   Given I am signed in
  #   And another Writer has an Idea
  #   When I visit that Idea page
  #   Then I cannot access the Idea page
  scenario 'the page of other writer idea cannot be accesed' do
    skip 'pending'
    visit idea_path(idea)
    expect(page).to_not have_content(idea.body)
  end
end