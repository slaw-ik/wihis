class CreatePointTagsTable < ActiveRecord::Migration
  def change
      create_table :points_tags do |t|
        t.integer :point_id
        t.integer :tag_id
      end
    end
end
