class AppointmentMailer < ActionMailer::Base
  default :from => "appointmentrequest@csnip.org"
  
  def appointment_submitted(appointment)
    @appointment = appointment
    #@url = link_to(appointment)
    mail(:to => appointment.email, :subject => 'Your C-SNIP appointment request')
  end
  
  def appointment_accepted(appointment)
    @appointment = appointment
    mail(:to => appointment.email, :subject => 'Your C-SNIP appointment request is approved')
  end
  
  def appointment_denied(appointment)
    @appointment = appointment
    mail(:to => appointment.email, :subject => 'Your C-SNIP appointment request')
  end
  
end
