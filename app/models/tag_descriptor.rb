class TagDescriptor < ActiveRecord::Base
  unloadable

  has_many :tags
  has_many :issues, through: :tags

  validates :description, presence: true, uniqueness: true
  validates :description, format: { with: /^(([A-Za-z0-9]+)[\s]?)+$/, message: "Tag description only allows letters, digits, separated by spaces." }

  before_save { |tag| tag.description.capitalize! }
end
