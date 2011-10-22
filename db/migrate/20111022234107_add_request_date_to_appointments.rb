class AddRequestDateToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :request_date, :date
  end
end
