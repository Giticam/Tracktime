class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :project_id
      t.integer :user_id
      t.datetime :dateworked
      t.integer :hours
      t.timestamps null: false
    end
  end
end
