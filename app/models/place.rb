class Place < ApplicationRecord

  belongs_to :user
  has_many :taggeds, :dependent => :destroy
  validates :name, :presence => { :message => "Name cannot be blank" }
  validates :address, :uniqueness =>{:scope => :user_id, :message => "has already been saved" }
  has_many :tags, :through => :taggeds, :source => :tag
end
