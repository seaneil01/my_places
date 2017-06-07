class Tagged < ApplicationRecord

  belongs_to :tag
  belongs_to :place
end
