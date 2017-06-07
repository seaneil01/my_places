class PlacesController < ApplicationController
  def index
    @places = Place.all

    render("places/index.html.erb")
  end

  def show
    @place = Place.find(params[:id])

    render("places/show.html.erb")
  end

  def new
    @place = Place.new
    @tagged = Tagged.new

    render("places/new.html.erb")
  end

  def create
    @place = Place.new
    @tagged = Tagged.new
    @place.name = params[:name]
    @place.comment = params[:comment]
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=chicago"+@place.name.gsub(" ", "%")
    parsed_data = JSON.parse(open(url).read)
    @place.address = parsed_data["results"][0]["formatted_address"]
    @place.neighborhood = parsed_data["results"][0]["address_components"][2]["long_name"]
    @place.user_id = params[:user_id]

#tagging
    @tags = Tag.all
    save_status = @place.save
    @tagged.place_id = @place.id
    @tagged.tag_id = params[:tag_id]
    save_status = @tagged.save
#end tagging
    if save_status == true
      redirect_to("/places/#{@place.id}", :notice => "Place created successfully.")
    else
      render("places/new.html.erb")
    end
  end

  def edit
    @place = Place.find(params[:id])

    render("places/edit.html.erb")
  end

  def update
    @place = Place.find(params[:id])

    @place.address = params[:address]
    @place.name = params[:name]
    @place.comment = params[:comment]
    @place.neighborhood = params[:neighborhood]
    @place.user_id = params[:user_id]

    save_status = @place.save

    if save_status == true
      redirect_to("/places/#{@place.id}", :notice => "Place updated successfully.")
    else
      render("places/edit.html.erb")
    end
  end

  def destroy
    @place = Place.find(params[:id])

    @place.destroy

    if URI(request.referer).path == "/delete_place/#{@place.id}"
      redirect_to("/", :notice => "Place deleted.")
    else
      redirect_to("/", :notice => "Place deleted.")
    end
  end
end
