class AddStatusToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :status, :string
  end
end
