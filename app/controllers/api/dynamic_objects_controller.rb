class API::DynamicObjectsController < API::BaseController
  def search
    if params[:radius]
      center = [params[:center][:lat], params[:center][:lng]]
      radius = params[:radius]

      @dynamic_objects = DynamicObject.near(center, radius, units: :km)
    else
      bounding_box = [params[:south], params[:west], params[:north], params[:east]]
      @dynamic_objects = DynamicObject.within_bounding_box(bounding_box)
    end

    render :search
  end
end
