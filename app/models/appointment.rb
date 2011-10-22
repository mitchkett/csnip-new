class Appointment < ActiveRecord::Base

  validates_presence_of :last_name, :first_name, :phone, :pet_type, :gender, :age, :pet_name
  validates_presence_of :street, :city, :postal_code, :county
  before_create :set_acquired_from
  
  attr_accessor :acquired_from_type, :acquired_from_other_description
  
  def set_acquired_from
    if acquired_from_type == 'other'
      self.acquired_from = "other: #{acquired_from_other_description}"
    elsif acquired_from_type.blank?
      self.acquired_from = "none"
    else
      self.acquired_from = acquired_from_type
    end
  end

end
