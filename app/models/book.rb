# == Schema Information
#
# Table name: books
#
#  id    :integer          not null, primary key
#  title :string
#

class Book < ActiveRecord::Base
  belongs_to :user
end
