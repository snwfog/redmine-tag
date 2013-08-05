class TagDescriptor < ActiveRecord::Base
  unloadable

  has_many :tags
  has_many :issues, through: :tags

end
