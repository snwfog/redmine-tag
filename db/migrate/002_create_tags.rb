class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :tag_descriptor
      t.belongs_to :issue
      t.integer :severity

      t.timestamps
    end
  end
end
