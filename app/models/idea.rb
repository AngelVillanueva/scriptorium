# == Schema Information
#
# Table name: ideas
#
#  id      :integer          not null, primary key
#  title   :string
#  body    :text
#  user_id :integer
#

class Idea < ActiveRecord::Base
    validates :title, :body, presence: true
    belongs_to :user
end
