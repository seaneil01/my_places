Rails.application.routes.draw do
  # Routes for the Tagged resource:
  root "places#index"

  # CREATE
  get "/taggeds/new", :controller => "taggeds", :action => "new"
  get "/create_tagged/:place_id/:tag_id", :controller => "taggeds", :action => "create"

  # READ
  get "/taggeds", :controller => "taggeds", :action => "index"
  get "/taggeds/:id", :controller => "taggeds", :action => "show"

  # UPDATE
  get "/taggeds/:id/edit", :controller => "taggeds", :action => "edit"
  post "/update_tagged/:id", :controller => "taggeds", :action => "update"

  # DELETE
  get "/delete_tagged/:id", :controller => "taggeds", :action => "destroy"
  #------------------------------

  # Routes for the Place resource:
  # CREATE
  get "/places/new", :controller => "places", :action => "new"
  post "/create_place", :controller => "places", :action => "create"
  post "/create_place_test", :controller => "places", :action => "create_test"

  # READ
  get "/places", :controller => "places", :action => "index"
  get "/places/:id", :controller => "places", :action => "show"

  # UPDATE
  get "/places/:id/edit", :controller => "places", :action => "edit"
  post "/update_place/:id", :controller => "places", :action => "update"

  # DELETE
  get "/delete_place/:id", :controller => "places", :action => "destroy"
  #------------------------------

  # Routes for the Tag resource:
  # CREATE
  get "/tags/new", :controller => "tags", :action => "new"
  post "/create_tag", :controller => "tags", :action => "create"
  post "/create_tag_in_place", :controller => "tags", :action => "create_tag_in_place"
  # READ
  get "/tags", :controller => "tags", :action => "index"
  get "/tags/:id", :controller => "tags", :action => "show"

  # UPDATE
  get "/tags/:id/edit", :controller => "tags", :action => "edit"
  post "/update_tag/:id", :controller => "tags", :action => "update"

  # DELETE
  get "/delete_tag/:id", :controller => "tags", :action => "destroy"

  #Search by Tag
  get "/tag_search", :controller => "tags", :action => "search_by_tag"
  get "/tag_search/:id", :controller => "tags", :action => "search_results"

  #Search by Neighborhood
  get "/neighborhoods", :controller => "places", :action => "get_neighborhood"
  get "/neighborhoods/:neighborhood", :controller => "places", :action => "search_results"

  get "/test", :controller =>"places", :action => "test"

  #------------------------------

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
