class CreateLiquors < ActiveRecord::Migration
  def change
    create_table :liquors do |t|
    t.string :name
    t.string :description
    t.float :price
    t.integer :user_id
    end
  end
end
