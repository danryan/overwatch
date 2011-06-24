class EventsController < ApplicationController
  respond_to :html, :json
  
  def index
    @events = Event.all
    respond_with @events
  end
  
  def show
    @event = Event.get(params[:id])
    respond_with @event
  end
  
  def new
    @event = Event.new
    @email_event = Event::Email.new
    @http_event = Event::HTTP.new
    @sms_event = Event::SMS.new
    @stdout_event = Event::STDOUT.new
    @xmpp_event = Event::XMPP.new
    
    respond_with @event
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      respond_with @event
    end
  end
  
  def edit
    @event = Event.get(params[:id])
    respond_with @event
  end
  
  def update
    @event = Event.get(params[:id])
    if @event.update(params[:event])
      respond_with @event
    end
  end
  
  def destroy
    @event = Event.get(params[:id])
    if @event.destroy
      respond_with @event 
    end
  end
end
