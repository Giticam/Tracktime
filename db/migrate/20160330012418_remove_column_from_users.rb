class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :company_id, :integer
  end
end
