class AppointmentMailer < ActionMailer::Base
  default :from => "appointmentrequest@csnip.org"
  
  def appointment_submitted(appointment)
    @appointment = appointment
    #@url = link_to(appointment)
    mail(:to => appointment.email, :subject => 'Your C-SNIP appointment request')
  end
end
