class AddPrintedDateToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :printed_date, :date
  end
end
