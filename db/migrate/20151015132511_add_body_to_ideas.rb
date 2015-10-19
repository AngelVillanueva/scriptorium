class AddBodyToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :body, :text
  end
end
