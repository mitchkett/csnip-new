class AddOldDobToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :date_of_birth_text, :string
  end
end
