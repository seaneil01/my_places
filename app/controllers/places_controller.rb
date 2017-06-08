class PlacesController < ApplicationController
  def index
    @places = Place.all

    render("places/index.html.erb")
  end

  def get_neighborhood
    @ordered_place = Place.order(:neighborhood)
    @places = @ordered_place.where(:user_id => current_user.id)
    @neighborhoods = @places.distinct.pluck(:neighborhood)
    render("neighborhoods/neighborhoods.html.erb")
  end

  def search_results
    @ordered_place = Place.order(:neighborhood)
    @places = @ordered_place.where(:user_id => current_user.id)
    @neighborhoods = @places.distinct.pluck(:neighborhood)
    @n_places = Place.where(:neighborhood=> params[:neighborhood])
    @n_places = @n_places.where(:user_id => current_user.id)
    render("neighborhoods/search_results.html.erb")
  end

  def show
    @place = Place.find(params[:id])
    @tagged = Tagged.where(:place_id => @place.id)
    @tags = Tag.where(:user_id=> current_user.id)

    @arr = Array.new
    @tagged.each do |tagged|
      @arr.push(tagged.tag_id)
    end

    render("places/show.html.erb")
  end

  def new
    @place = Place.new
    render("places/new.html.erb")
  end

  def create
    @place = Place.new
    @place.name = params[:name]
    address = params[:address]
    address.gsub(" ", "%")
    @place.comment = params[:comment]
    url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query="+address+"&key=AIzaSyCP83Yxqun0Tgjqj4rhp7M7-i1P4aagazA"
    parsed_data = JSON.parse(open(url).read)
    @place.address = parsed_data["results"][0]["formatted_address"]
    @place.name = parsed_data["results"][0]["name"]
    url2 = "https://maps.googleapis.com/maps/api/geocode/json?address="+address
    parsed_data2 = JSON.parse(open(url2).read)
    @place.neighborhood = parsed_data2["results"][0]["address_components"][2]["long_name"]
    @place.user_id = params[:user_id]
    save_status = @place.save
    #tagging
    # @tagged = Tagged.new
    # @tags = Tag.all
    # @tagged.place_id = @place.id
    # @tagged.tag_id = params[:tag_id]
    # save_status = @tagged.save
    #end tagging
    if save_status == true
      redirect_to("/places/#{@place.id}", :notice => "Place created successfully.")
    else
      redirect_to("/")
    end
  end

  def edit
    @place = Place.find(params[:id])
    #@tagged = Tagged.new
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
    #tagging
    #@tagged = Tagged.new
    #@tags = Tag.all
    #@tagged.place_id = @place.id
    #@tagged.tag_id = params[:tag_id]
    #save_status = @tagged.save
    #end tagging
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

  def test
    @place = Place.new
    @address = params[:address]
    render("/places/new.html.erb")
  end
end
