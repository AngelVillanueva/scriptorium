# == Schema Information
#
# Table name: books
#
#  id    :integer          not null, primary key
#  title :string
#

describe Book do

  before(:each) { @book = Book.new(title: 'My first book') }

  subject { @book }

  it { should respond_to(:title) }

  it "#title returns a string" do
    expect(@book.title).to match 'My first book'
  end

  it { should respond_to(:user) }

end
