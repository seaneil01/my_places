class Tag < ApplicationRecord

  belongs_to :user
  has_many :taggeds, :dependent => :destroy

  has_many :places, :through => :taggeds, :source => :place
  validates :name, :presence => { :message => "Tag cannot be blank" }
  validates :name, uniqueness: {:scope => [:user_id], case_sensitive: false, :message => "%{value} has already been used"}

end
