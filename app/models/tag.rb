class Tag < ActiveRecord::Base
  unloadable

  default_scope { includes(:tag_descriptor) }

  belongs_to :issue
  belongs_to :tag_descriptor


  validates :severity, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 9 }

  validates :tag_descriptor_id, uniqueness: { scope: [:issue_id, :severity] }


  def to_s
    self.tag_descriptor.description
  end
end

