class TagsController < ApplicationController
  def index
    @tags = Tag.all

    render("tags/index.html.erb")
  end
  def search_by_tag
    @tags = Tag.all

    render("tags/search_by_tag.html.erb")
  end

  def show
    @tag = Tag.find(params[:id])

    render("tags/show.html.erb")
  end

  def search_results
    @tags = Tag.all
    @tagged = Tagged.where(:tag_id => params[:id])

    render("tags/search_results.html.erb")
  end

  def new
    @tag = Tag.new

    render("tags/new.html.erb")
  end

  def create
    @tag = Tag.new

    @tag.name = params[:name]
    @tag.user_id = params[:user_id]

    save_status = @tag.save

    if save_status == true
      redirect_to("/tags", :notice => "Tag created successfully.")
    else
      render("tags/new.html.erb")
    end
  end

  def edit
    @tag = Tag.find(params[:id])

    render("tags/edit.html.erb")
  end

  def update
    @tag = Tag.find(params[:id])

    @tag.name = params[:name]
    @tag.user_id = params[:user_id]

    save_status = @tag.save

    if save_status == true
      redirect_to("/tags/#{@tag.id}", :notice => "Tag updated successfully.")
    else
      render("tags/edit.html.erb")
    end
  end

  def destroy
    @tag = Tag.find(params[:id])

    @tag.destroy

    if URI(request.referer).path == "/tags/#{@tag.id}"
      redirect_to("/", :notice => "Tag deleted.")
    else
      redirect_to("/", :notice => "Tag deleted.")
    end
  end
end
