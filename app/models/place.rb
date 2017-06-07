class Place < ApplicationRecord

  belongs_to :user
  has_many :taggeds, :dependent => :destroy
  validates :name, :presence => { :message => "Name cannot be blank" }
  validates :name, :uniqueness =>{:scope => [:address, :user_id]}
  has_many :tags, :through => :taggeds, :source => :tag
end
