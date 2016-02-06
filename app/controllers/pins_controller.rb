class PinsController < ApplicationController
  
  def index
    @pins = Pin.all
  end
  
  def show
    @pin = Pin.find(params[:id])
  end

  def show_by_name
    @pin = Pin.find_by_slug(params[:slug])
    render :show
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.create(pin_params)

    if @pin.valid?
      @pin.save
      redirect_to pin_path(@pin.id)
    else
      @errors = @pin.errors
      render :new
    end
  end

  def edit
    @pin = Pin.find(params[:id])
  end

  def update
    @pin = Pin.find(params[:id])
    @pin.update_attributes(pin_params)
    
    if @pin.valid?
      @pin.save  
      redirect_to pin_path(@pin.id)
    else
      @errors = @pin.errors
      render :edit
    end
  end
  
  private

    def pin_params
      params.require(:pin).permit(:title, :url, :slug, :text, :category_id, :image [:image_file_name, :image_file_size, :image_content_type, :image_updated_at])
    end

end