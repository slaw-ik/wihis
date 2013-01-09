class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :point_id
      t.text :text

      t.timestamps
    end
  end
end
