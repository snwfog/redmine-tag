class Tag < ActiveRecord::Base
  unloadable
  belongs_to :issue
  belongs_to :tag_descriptor

  validates :severity, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9 }



end

