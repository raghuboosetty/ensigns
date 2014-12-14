class Item < ActiveRecord::Base
  STATUSES = { in_stock: 'In Stock', reserved: 'Reserved', out_stock: 'Out of Stock', damaged: 'Damaged' }
  SIZES = { xs: 'XS', s: 'S', m: 'M', l: 'L', xl: 'XL', xxl: 'XXL' }
  PAYMENT_STATUSES = { full_pending: 'Full Pending', partial_pending: 'Partial Pending', paid: 'Paid'}
  belongs_to :customer

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>", mini_thumb: "50x50>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  class << self
    def status_options
      STATUSES.map{ |k,v| [v, k] }
    end

    def size_options
      SIZES.map{ |k,v| [v, k] }
    end

    def payment_status_options
      PAYMENT_STATUSES.map{ |k,v| [v, k] }
    end
  end
end
