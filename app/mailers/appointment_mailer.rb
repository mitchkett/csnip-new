class AppointmentMailer < ActionMailer::Base
  default :from => "support@csnip.org"
  
  def appointment_submitted(appointment)
    @appointment = appointment
    #@url = link_to(appointment)
    #unless appointment.email.blank?
    mail(:to => appointment.email, :subject => 'Your C-SNIP appointment request')
  end
end
