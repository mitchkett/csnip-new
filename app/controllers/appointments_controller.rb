class AppointmentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]

  def index
    if current_user.is_admin?
      @search = Appointment.order('id DESC')
      if params.has_key?(:last_name)
        @search = @search.by_last_name(params[:last_name])
      end
    
      if params.has_key?(:county)
        @search = @search.by_county(params[:county])
      end
    
      if params.has_key?(:zip)
        @search = @search.by_zip(params[:zip])
      end
    
      if params.has_key?(:pet_type)
        @search = @search.by_pet_type(params[:pet_type])
      end
    
      if params.has_key?(:age)
        @search = params[:age] == "1" ? @search.younger : @search.older
      end
    
      if params.has_key?(:from)
        from_date = Date.strptime(params[:from], "%Y-%m-%d")
        @search = @search.from_date(from_date)
      end
    
      if params.has_key?(:to)
        to_date = Date.strptime(params[:to], "%Y-%m-%d")
        @search = @search.to_date(to_date)
      end
    
      if params.has_key?(:pet_vaccinated)
        @search = params[:pet_vaccinated] == "1" ? @search.vaccinated : @search.not_vaccinated
      end
    
      if params.has_key?(:seen_vet)
        @search = params[:seen_vet] == "1" ? @search.seen_vet : @search.not_seen_vet
      end
    
      if params.has_key?(:status)
        @search = @search.by_status(params[:status])
      end
    
      if params.has_key?(:printed)
        @search = params[:printed] == "1" ? @search.printed : @search.not_printed
      end
    
      #@search.pet_type_equals_any = %w[dog cat] unless params[:search] && params[:search][:pet_type_equals_any]
      @appointments = @search.paginate(:page => params[:page], :per_page => 50)
    
      render :layout => 'admin'
    else
      redirect_to new_appointment_path
    end
  end
  
  def search
    search_params = {}
    search_params[:last_name] = Regexp.escape(params[:last_name]) if params.has_key?(:last_name) && !params[:last_name].blank?
    search_params[:county] = Regexp.escape(params[:county]) if params.has_key?(:county) && !params[:county].blank?
    search_params[:zip] = Regexp.escape(params[:zip]) if params.has_key?(:zip) && !params[:zip].blank?
    search_params[:pet_type] = Regexp.escape(params[:pet_type]) if params.has_key?(:pet_type) && !params[:pet_type].blank?
    search_params[:age] = Regexp.escape(params[:age]) if params.has_key?(:age) && !params[:age].blank?
    search_params[:pet_vaccinated] = Regexp.escape(params[:pet_vaccinated]) if params.has_key?(:pet_vaccinated) && !params[:pet_vaccinated].blank?
    search_params[:from] = params[:from] if params.has_key?(:from) && !params[:from].blank?
    search_params[:to] = params[:to] if params.has_key?(:to) && !params[:to].blank?
    search_params[:seen_vet] = Regexp.escape(params[:seen_vet]) if params.has_key?(:seen_vet) && !params[:seen_vet].blank?
    search_params[:status] = params[:status] if params.has_key?(:status) && !params[:status].blank?
    search_params[:printed] = params[:printed] if params.has_key?(:printed) && !params[:printed].blank?
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
      AppointmentMailer.appointment_accepted(@appointment).deliver unless @appointment.email.blank?
      redirect_to appointments_path
    else
      render :action => 'show'
    end
  end
  
  def deny
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(:status => "DENIED")
      flash[:warn] = "Appointment #{@appointment.id.to_s} with #{@appointment.client_full_name} has been denied."
      AppointmentMailer.appointment_denied(@appointment).deliver unless @appointment.email.blank?
      redirect_to appointments_path
    else
      render :action => 'show'
    end
  end

end
