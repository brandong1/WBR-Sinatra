class CreateLiquors < ActiveRecord::Migration
  def change
    t.string :name
    t.string :description
    t.float :price
    t.integer :user_id
  end
end
