class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :company_id
      t.integer :default_charge

      t.timestamps null: false
    end
  end
end
