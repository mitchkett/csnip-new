class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :last_name
      t.string :first_name
      t.string :phone
      t.string :alternate_phone
      t.string :pet_name
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :county
      t.string :pet_type
      t.string :breed
      t.string :color
      t.string :gender
      t.text :surgeries_explanation
      t.text :health_concerns_explanation
      t.text :medications_explanation
      t.date :date_of_birth
      t.string :owned_for
      t.string :vet_name
      t.string :had_litter_when
      t.integer :testicle_count
      t.string :weight
      t.boolean :want_chip_implant
      t.boolean :want_rabies_vaccination
      t.text :comments
      t.string :email
      t.string :acquired_from
      t.string :best_time_to_contact_client
      t.string :pet_vaccinated
      t.string :pet_pregnant
      t.string :pet_in_heat
      t.string :pet_testicles_descended
      t.string :has_pet_seen_vet
      t.string :where_pet_lives
      t.boolean :is_pet_tame
      t.date :date_preferred

      t.timestamps
    end
  end
end
