class AppointmentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  layout 'admin'

  def index
    @search = Appointment.descend_by_id.search(params[:search])
    @search.pet_type_equals_any = %w[dog cat] unless params[:search] && params[:search][:pet_type_equals_any]
    
    @appointments = @search.paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def print
    @appointments = Appointment.find(params[:ids])
    @appointments.each { |a| a.print! }
  end

  def new
    @appointment = Appointment.new(params[:appointment])
    render :layout => 'application'
  end

  def create
    @appointment = Appointment.new(params[:appointment])
    @appointment.date_of_birth = Date.strptime(params[:appointment][:date_of_birth], "%Y-%m-%d")
    if @appointment.save
      render :layout => 'application'
    else
      render :action => :new, :layout => 'application'
    end
  end

end
