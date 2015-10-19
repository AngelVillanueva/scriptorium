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
  scenario 'users cannot see ideas from other writers' do
    skip 'skip until Pundit is under control'
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user, email: "user2@example.com")
    idea = FactoryGirl.create(:idea, user: user2)
    login_as(user1, :scope => :user)
    visit ideas_path(user1)
    expect(page).to_not have_selector("li.idea")
    expect(user2.ideas.count).to eq(1)
    expect(idea.user).to equal(user2)
    visit idea_path(idea)
    expect(page).to_not have_content(idea.body)
  end
  scenario 'users can go to an Idea page from the Ideas index' do
    user = FactoryGirl.create(:user)
    idea = FactoryGirl.create(:idea, user: user)
    login_as(user, :scope => :user)
    visit ideas_path(user)
    click_link idea.title
    expect(page).to have_content(idea.title)
    expect(page).to have_content(idea.body)
  end
end