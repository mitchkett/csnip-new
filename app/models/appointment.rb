class Appointment < ActiveRecord::Base

  validates_presence_of :last_name, :first_name, :phone, :best_time_to_contact_client, :street, :city, :postal_code, :county
  validates_presence_of :pet_name, :pet_type, :gender, :date_of_birth
  
  validates_presence_of :weight, :unless => Proc.new { |appt| appt.pet_type == "cat" }
  
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
  
  def age
    if !self.date_of_birth.blank?
      (Time.now - self.date_of_birth).to_s
    else
      "Unknown"
    end
  end

end
