class Pin < ActiveRecord::Base
  belongs_to :user
  #belongs_to :category
  validates_inclusion_of :aggression_type, in: ["sexism", "racism", "homophobia"]
  acts_as_mappable

  def coordinate
    [self.lat, self.lng]
  end
end
