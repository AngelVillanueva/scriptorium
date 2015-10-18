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
        FactoryGirl.create(:idea, title: "My great Idea number #{index}")
      end
      login_as(user, :scope => :user)
      visit user_path(user)
      click_link I18n.t("My Ideas")
      expect(page).to have_content(I18n.t("My Ideas"))
      expect(page).to have_selector("li.idea", count: 3)
      expect(page).to have_content("My great Idea number 2")
  end
end