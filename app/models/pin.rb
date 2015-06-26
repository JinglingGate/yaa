class Pin < ActiveRecord::Base
  belongs_to :user
  #belongs_to :category
  validates_inclusion_of :type, in: ["sexism", "racism", "homophobia"]
end
