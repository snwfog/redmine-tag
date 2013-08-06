class AddIndexToTagDescriptor < ActiveRecord::Migration
  def change
    add_index :tag_descriptors, :description, unique: true, null: false
  end
end
