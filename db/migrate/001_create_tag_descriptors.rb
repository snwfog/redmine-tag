class CreateTagDescriptors < ActiveRecord::Migration
  def change
    create_table :tag_descriptors do |t|
      t.string :description
      t.timestamps
    end
  end
end
