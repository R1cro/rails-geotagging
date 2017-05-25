class WelcomeController < ApplicationController
  #GET "/"
  def index
    @dynamic_objects = DynamicObject.last(6).reverse
    create_markers
  end

  # Creates all the markers for the farms... Used to on the map in the view.
  def create_markers
    @all_dynamic_objects = DynamicObject.all
    @hash = Gmaps4rails.build_markers(@all_dynamic_objects) do |object, marker|
      marker.lat object.latitude
      marker.lng object.longitude
    end
  end
end
