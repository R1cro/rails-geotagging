class DynamicObjectsController < ApplicationController
  before_action :authenticate_user!, except: %w(index search show)

  def index
    @dynamic_object = DynamicObject.all
  end

  def show
    @dynamic_object = DynamicObject.find(params[:id])

    @marker_hash = Gmaps4rails.build_markers(@dynamic_object) do |object, marker|
      marker.lat object.latitude
      marker.lng object.longitude
      marker.infowindow "<a target='blank' href='https://www.google.com/maps/place/" + "#{object.address}" + "'>Get Directions [Google Maps]</a>"
      marker.json(title: object.name)
    end

    if current_user
      @connection = Connection.where(user_id: current_user.id, dynamic_object_id: @dynamic_object.id)
    end
  end

  def new
    @dynamic_object_type_id = params[:dynamic_object_type_id] || 1
    dynamic_object_type = DynamicObjectType.find(@dynamic_object_type_id)
    @dynamic_object = DynamicObject.new(dynamic_object_type: dynamic_object_type)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @dynamic_object = DynamicObject.new(dynamic_object_params)
    @dynamic_object.user_id = current_user.id
    if @dynamic_object.save
      redirect_to dynamic_object_path(@dynamic_object), notice: "Welcome to the family! We are glad you've chosen us to help represent your object."
    else
      render :new
    end
  end

  def edit
    @dynamic_object = DynamicObject.find(params[:id])
    
    @marker_hash = Gmaps4rails.build_markers(@dynamic_object) do |object, marker|
      marker.lat object.latitude
      marker.lng object.longitude
    end
  end

  def update
    @dynamic_object = DynamicObject.find(params[:id])
    if is_owner(@dynamic_object)
      if @dynamic_object.update_attributes(dynamic_object_params)
        redirect_to dynamic_object_path(@dynamic_object),  notice: "#{@dynamic_object.name} updated successfully."
      else
        render edit_dynamic_object_path(@dynamic_object), notice: "Error updating object."
      end
    else
      redirect_to dynamic_object_path(@dynamic_object), notice: "You don't have permission to go there."
    end
  end

  def search
    @location = params[:search]
    @distance = params[:miles]
    @dynamic_object = DynamicObject.near(@location, @distance)

    if @location.empty?
      redirect_to :root, notice: "You can't search without a search term; please enter a location and retry!"
    else
      if @dynamic_object.length < 1
        redirect_to :root, notice: "Sorry! We couldn't find any objects within #{@distance} miles of #{@location}."
      else
        search_map(@dynamic_object)
      end
    end
  end

  private

    def search_map(objects)
      @dynamic_objects = objects
      @marker_hash = Gmaps4rails.build_markers(@dynamic_object) do |object, marker|
        marker.lat object.latitude
        marker.lng object.longitude
        marker.infowindow "<a href='/dynamic_objects/" + "#{object.id}" + "'>#{object.name}, #{object.address}</a>"
        marker.json(title: object.name, id: object.id)
      end
    end

    def is_owner(object)
      @dynamic_object = object
      if current_user.id == @dynamic_object.user_id
        return true
      else
        return false
      end
    end

    def set_user
      @user = current_user
    end

    def dynamic_object_params
      params.require(:dynamic_object).permit!
    end
end
