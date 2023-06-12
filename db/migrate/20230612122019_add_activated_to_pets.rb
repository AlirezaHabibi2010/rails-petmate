class AddActivatedToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :activated, :boolean, default: :true
  end
end
