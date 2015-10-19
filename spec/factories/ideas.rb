# == Schema Information
#
# Table name: ideas
#
#  id      :integer          not null, primary key
#  title   :string
#  body    :text
#  user_id :integer
#

FactoryGirl.define do
  factory :idea do
    title "My great Idea"
    body "What if Rocinante met Babieca?"
    user
  end
end
