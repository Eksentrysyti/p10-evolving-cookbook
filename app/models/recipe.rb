class Recipe < ActiveRecord::Base
  # Remember to create a migration!
  serialize :ingredient_list

  belongs_to :user
end
