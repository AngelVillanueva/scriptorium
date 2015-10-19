# == Schema Information
#
# Table name: ideas
#
#  id      :integer          not null, primary key
#  title   :string
#  body    :text
#  user_id :integer
#

describe Idea do

  before(:each) { @idea = Idea.new(title: "My next great Idea", body: 'What if Don Quixote was a woman?') }

  subject { @idea }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

end
