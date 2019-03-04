class ChangeLiquorPriceFromFloatToString < ActiveRecord::Migration
  def change
    change_column :liquors,:price, :string
  end
end
