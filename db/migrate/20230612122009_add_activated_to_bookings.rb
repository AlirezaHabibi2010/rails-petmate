class AddActivatedToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :activated, :boolean, default: :true
  end
end
