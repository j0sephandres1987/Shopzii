class Photo < ActiveRecord::Base
  belongs_to :product
  has_attached_file :photo, styles: { original: "600x600#", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
