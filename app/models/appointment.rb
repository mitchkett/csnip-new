class Appointment < ActiveRecord::Base

  validates :last_name, :first_name, :phone, :best_time_to_contact_client, :street, :city, :postal_code, :county, :presence => true
  validates :pet_name, :pet_type, :gender, :presence => true
  
  validates :weight, :presence => { :if => lambda { |appt| appt.pet_type == "dog" } }
  validates :breed, :presence => { :if => lambda { |appt| appt.pet_type == "dog" } }  
  validates :pet_testicles_descended, :presence => { :if => lambda { |appt| appt.gender == "male" } }
  validates :testicle_count, :presence => { :if => lambda { |appt| appt.gender == "male" && appt.pet_testicles_descended == "yes" } }
  validates :request_date, :presence => true, :date => { :after => Time.now, :before => Time.now + 3.weeks }
  validates :date_of_birth, :presence => true, :date => { :before => Time.now }
  validates :email, :confirmation => true
  
  before_create :set_acquired_from
  before_create :set_status_to_pending
  
  attr_accessor :acquired_from_type, :acquired_from_other_description, :requested_appointment_date
  attr_reader :age
  
  class << self
    def by_last_name(last_name)
      where("last_name LIKE ?", "%#{last_name}%")
    end
    
    def by_county(county)
      where("county LIKE ?", "%#{county}%")
    end
    
    def by_zip(postal_code)
      where(:postal_code => postal_code)
    end
    
    def by_pet_type(pet_type)
      where(:pet_type => pet_type)
    end
    
    def from_date(from)
      where("created_at >= ?", from)
    end
    
    def to_date(to)
      where(["created_at <= ?", to + 1.day])
    end
    
    def older
      where("date_of_birth <= ?", Time.now - 6.months)
    end
    
    def younger
      where("date_of_birth > ?", Time.now - 6.months)
    end
    
    def vaccinated
      where("pet_vaccinated LIKE '%Yes%'")
    end
    
    def not_vaccinated
      where("pet_vaccinated LIKE '%No %'")
    end
    
    def seen_vet
      where(:has_pet_seen_vet => true)
    end
    
    def not_seen_vet
      where(:has_pet_seen_vet => false)
    end
    
    def by_status(status)
      where(:status => status)
    end
    
    def printed
      where("printed_date IS NOT NULL")
    end
    
    def not_printed
      where("printed_date IS NULL")
    end
  end
  
  def requested_appointment_date=(val)
    begin
      self.request_date = Date.strptime(params[:appointment][:request_date], "%Y-%m-%d")
    rescue
      self.request_date = nil
    end
  end
  
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
        :best_time_to_contact_client => best_time_to_contact_client,
        :email => email,
        :request_date => request_date,
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
    if self.date_of_birth.blank?
      "Unknown"
    else
      years = Time.now.to_date.year - date_of_birth.year
      months = Time.now.to_date.month - date_of_birth.month
      "#{years} year(s), #{months} month(s)"
    end
  end
  
  def birth_date
    if self.date_of_birth.blank?
      self.date_of_birth_text
    else
      self.date_of_birth.strftime("%m-%d-%Y")
    end
  end
  
  def set_status_to_pending
    self.status = "PENDING"
  end

end
