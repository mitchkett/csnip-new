class Appointment < ActiveRecord::Base

  validates_presence_of :last_name, :first_name, :phone, :best_time_to_contact_client, :street, :city, :postal_code, :county
  validates_presence_of :pet_name, :pet_type, :gender, :date_of_birth
  
  validates_presence_of :weight, :if => lambda { |appt| appt.pet_type == "dog" }
  validates_presence_of :pet_testicles_descended, :if => lambda { |appt| appt.gender == "male" }
  validates_presence_of :testicle_count, :if => lambda { |appt| appt.gender == "male" }
  
  before_create :set_acquired_from
  
  attr_accessor :acquired_from_type, :acquired_from_other_description
  attr_reader :age
  
  def set_acquired_from
    if acquired_from_type == 'other'
      self.acquired_from = "other: #{acquired_from_other_description}"
    elsif acquired_from_type.blank?
      self.acquired_from = "none"
    else
      self.acquired_from = acquired_from_type
    end
  end
  
  def person_attributes
      { :first_name => first_name, 
        :last_name => last_name, 
        :phone => phone, 
        :street => street,
        :city => city, 
        :postal_code => postal_code, 
        :county => county, 
        :alternate_phone => alternate_phone
      }
   end
   
   def client_name_last_comma_first
       [last_name, first_name].join(', ')
     end
     
     def client_full_name
       [first_name, last_name].join(' ')
     end
  
  def age
    "Unknown"
  end

end
