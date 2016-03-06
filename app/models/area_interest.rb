class AreaInterest < ActiveRecord::Base
  belongs_to :area
  belongs_to :owner, polymorphic: true
end
