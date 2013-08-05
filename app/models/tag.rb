class Tag < ActiveRecord::Base
  unloadable
  belongs_to :issue
  belongs_to :tag_descriptor
end
