class TaggedsController < ApplicationController
  def index
    @taggeds = Tagged.all

    render("taggeds/index.html.erb")
  end

  def show
    @tagged = Tagged.find(params[:id])

    render("taggeds/show.html.erb")
  end

  def new
    @tagged = Tagged.new

    render("taggeds/new.html.erb")
  end

  def create
    @tags = Tag.where(:user_id=> current_user.id)
    @places = Place.all
    @tagged = Tagged.new

    @tagged.place_id = params[:place_id]
    @tagged.tag_id = params[:tag_id]

    save_status = @tagged.save

    if save_status == true
      redirect_to("/places/#{@tagged.place_id}")
    else
      render("taggeds/new.html.erb")
    end
  end

  def edit
    @tagged = Tagged.find(params[:id])

    render("taggeds/edit.html.erb")
  end

  def update
    @tagged = Tagged.find(params[:id])

    @tagged.place_id = params[:place_id]
    @tagged.tag_id = params[:tag_id]

    save_status = @tagged.save

    if save_status == true
      redirect_to("/taggeds/#{@tagged.id}", :notice => "Tag updated successfully.")
    else
      render("taggeds/edit.html.erb")
    end
  end

  def destroy
    @tagged = Tagged.find(params[:id])
    @tagged.destroy

    if URI(request.referer).path == "/taggeds/#{@tagged.id}"
      redirect_to("/")
    else
      redirect_to("/places/#{@tagged.place.id}")
    end
  end
end
