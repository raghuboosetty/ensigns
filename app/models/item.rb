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

# == Schema Information
#
# Table name: items
#
#  id                 :integer          not null, primary key
#  customer_id        :integer
#  token              :string(255)
#  size               :string(255)
#  code               :string(255)
#  wholesale_price    :integer
#  retail_price       :integer
#  selling_price      :integer
#  discount           :integer
#  status             :string(255)
#  payment_status     :string(255)
#  description        :text
#  paid_amount        :integer
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_items_on_customer_id  (customer_id)
#
