# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples
#cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

User.create!(:first_name => "Craig", :last_name => "Labenz", :email => "craig.labenz@gmail.com", :password => "password", :password_confirmation => "password", :is_admin => true)

50.times do |i|
  Appointment.create!(
    :first_name =>"Homer_#{i}", 
    :last_name =>"Simpson_#{i}", 
    :phone =>"(123) 123-3456", 
    :best_time_to_contact_client =>"anytime. I don't do anything at work_#{i}", 
    :alternate_phone =>"(234) 234-2234", 
    :email =>"homer_#{i}.simpson@sprinfieldisp.com", 
    :request_date =>Date.tomorrow, 
    :street =>"1234 Springfield Dr", 
    :city =>"Sprinfield", 
    :postal_code =>"123_#{i}", 
    :county =>"dunno", 
    :pet_name =>"Santa's Little Helper_#{i}", 
    :pet_type =>"dog", 
    :gender =>"male", 
    :weight =>"30 lbs", 
    :breed =>"whatever", 
    :color =>"some color", 
    :want_chip_implant =>"1", 
    :date_of_birth => Date.yesterday, 
    :want_rabies_vaccination =>"1", 
    :comments =>"hates cats", 
    :acquired_from_type =>"adopted", 
    :acquired_from_other_description =>"", 
    :owned_for =>"forever", 
    :where_pet_lives =>"both", 
    :is_pet_tame =>"1", 
    :pet_vaccinated =>"no", 
    :has_pet_seen_vet =>"1", 
    :vet_name =>"Dr Hibberts", 
    :surgeries_explanation =>"something", 
    :health_concerns_explanation =>"ya", 
    :medications_explanation =>"hurray", 
    :pet_in_heat =>"", 
    :pet_pregnant =>"", 
    :has_had_litter =>"", 
    :had_litter_when =>"", 
    :pet_testicles_descended =>"no", 
    :testicle_count =>"2")
end
