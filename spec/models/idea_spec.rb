describe Idea do

  before(:each) { @idea = Idea.new(title: "My next great Idea", body: 'What if Don Quixote was a woman?') }

  subject { @idea }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

end
