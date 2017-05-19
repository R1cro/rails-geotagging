class DynamicObjectTypesController < ApplicationController
  respond_to :html, :js

  def index
    @dynamic_object_types = DynamicObjectType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dynamic_object_types }
    end
  end

  # GET /dynamic_object_types/1
  # GET /dynamic_object_types/1.json
  def show
    @dynamic_object_type = DynamicObjectType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render json: @dynamic_object_type }
    end
  end

  # GET /dynamic_object_types/new
  # GET /dynamic_object_types/new.json
  def new
    @dynamic_object_type = DynamicObjectType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dynamic_object_type }
    end
  end

  # GET /dynamic_object_types/1/edit
  def edit
    @dynamic_object_type = DynamicObjectType.find(params[:id])
  end

  # POST /dynamic_object_types
  # POST /dynamic_object_types.json
  def create
    @dynamic_object_type = DynamicObjectType.new(dynamic_object_type_params)

    respond_to do |format|
      if @dynamic_object_type.save
        format.html { redirect_to @dynamic_object_type, notice: "Object type was successfully created." }
        format.json { render json: @dynamic_object_type, status: :created, location: @dynamic_object_type }
      else
        format.html { render action: "new" }
        format.json { render json: @dynamic_object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dynamic_object_types/1
  # PUT /dynamic_object_types/1.json
  def update
    @dynamic_object_type = DynamicObjectType.find(params[:id])

    respond_to do |format|
      if @dynamic_object_type.update_attributes(dynamic_object_type_params)
        format.html { redirect_to @dynamic_object_type, notice: "dynamic_object type was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dynamic_object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dynamic_object_types/1
  # DELETE /dynamic_object_types/1.json
  def destroy
    @dynamic_object_type = DynamicObjectType.find(params[:id])
    @dynamic_object_type.destroy

    respond_to do |format|
      format.html { redirect_to dynamic_object_types_url }
      format.json { head :no_content }
    end
  end

  def dynamic_object_type_params
    params.require(:dynamic_object_type).permit!
  end
end
