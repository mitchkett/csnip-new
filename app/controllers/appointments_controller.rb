class AppointmentsController < ApplicationController
  #before_filter :authenticate_user!, :except => [:new, :create]
  layout 'admin'

  def index
    @search = Appointment.order('id DESC')
    #@search.pet_type_equals_any = %w[dog cat] unless params[:search] && params[:search][:pet_type_equals_any]
    @appointments = Appointment.order("id DESC").paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def print
    @appointments = Appointment.find(params[:ids])
    #@appointments.each { |a| a.print! }
  end

  def new
    @appointment = Appointment.new(params[:appointment])
    render :layout => 'application'
  end

  def create
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
      AppointmentMailer.appointment_submitted(@appointment).deliver
      render :layout => 'application'
    else
      render :action => :new, :layout => 'application'
    end
  end

end
