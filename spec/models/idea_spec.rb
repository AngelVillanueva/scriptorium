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

  let(:idea) { FactoryGirl.build_stubbed :idea }

  subject { idea }

  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

end
