class Pin < ActiveRecord::Base
  belongs_to :user
  #belongs_to :category
  validates_inclusion_of :aggression_type, in: ["sexism", "racism", "homophobia"]

  def coordinate
    [self.latitude, self.longitude]
  end
end
