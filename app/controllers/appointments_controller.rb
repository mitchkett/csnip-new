class AppointmentsController < ApplicationController
  #before_filter :authenticate_user!, :except => [:new, :create]

  def index
    @search = Appointment.order('id DESC')
    if params.has_key?(:last_name)
      @search = @search.where("last_name LIKE '%#{params[:last_name]}%'")
    end
    
    if params.has_key?(:county)
      @search = @search.where("county LIKE '%#{params[:county]}%'")
    end
    
    if params.has_key?(:zip)
      @search = @search.where("postal_code LIKE '%#{params[:zip]}%'")
    end
    
    if params.has_key?(:pet_type)
      @search = @search.where("pet_type LIKE '%#{params[:pet_type]}%'")
    end
    #@search.pet_type_equals_any = %w[dog cat] unless params[:search] && params[:search][:pet_type_equals_any]
    @appointments = @search.paginate(:page => params[:page], :per_page => 50)
    
    render :layout => 'admin'
  end
  
  def search
    search_params = {}
    search_params[:last_name] = Regexp.escape(params[:last_name]) if params.has_key?(:last_name) && !params[:last_name].blank?
    search_params[:county] = Regexp.escape(params[:county]) if params.has_key?(:county) && !params[:county].blank?
    search_params[:zip] = Regexp.escape(params[:zip]) if params.has_key?(:zip) && !params[:zip].blank?
    search_params[:pet_type] = Regexp.escape(params[:pet_type]) if params.has_key?(:pet_type) && !params[:pet_type].blank?
    search_params[:from] = Regexp.escape(params[:from]) if params.has_key?(:from) && !params[:from].blank?
    search_params[:to] = Regexp.escape(params[:to]) if params.has_key?(:to) && !params[:to].blank?
    respond_to do |format|
      format.html { redirect_to(appointments_path(search_params)) }
      format.js
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    render :layout => 'admin'
  end

  def print
    @appointments = Appointment.find(params[:ids])
    @appointments.each do |appt|
      appt.update_attributes(:printed_date => Time.now)
    end
    render :layout => 'admin'
  end

  def new
    @appointment = Appointment.new(params[:appointment])
  end

  def create
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
      AppointmentMailer.appointment_submitted(@appointment).deliver unless @appointment.email.blank? 
      render :layout => 'application'
    else
      render :action => :new, :layout => 'application'
    end
  end
  
  def approve
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(:status => "APPROVED")
      flash[:notice] = "Appointment #{@appointment.id.to_s} with #{@appointment.client_full_name} has been approved."
      redirect_to appointments_path
    end
  end

end
