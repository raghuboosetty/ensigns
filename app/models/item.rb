class Item < ActiveRecord::Base
  STATUSES = { in_stock: 'In Stock', reserved: 'Reserved', out_stock: 'Out of Stock', damaged: 'Damaged' }
  SIZES = { xs: 'XS', s: 'S', m: 'M', l: 'L', xl: 'XL', xxl: 'XXL' }
  PAYMENT_STATUSES = { full_pending: 'Full Pending', partial_pending: 'Partial Pending', paid: 'Paid'}
  belongs_to :customer

  has_attached_file :photo, :styles => { original: "500x500>", :medium => "300x300>", mini_thumb: "50x50>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
  validates :token, :code, :wholesale_price, :status, presence: true  
  validates :token, :code, uniqueness: true
  validates :wholesale_price, :retail_price, :selling_price, :paid_amount, :discount, numericality: true, allow_nil: true
  
  before_validation :generate_token
  
  # items
  scope :sold, -> { where("payment_status IS NOT NULL") }
  scope :in_stock, -> { where(status: "in_stock") }
  scope :reserved, -> { where(status: "reserved") }
  scope :damaged, -> { where(status: "damaged") }
  
  # cost/money
  scope :cost, -> { sum(:wholesale_price) }
  scope :earned, -> { sum(:paid_amount) }
  scope :target, -> { sum(:selling_price) }
  scope :pending, -> { target - earned }
  
  def pending_amount
    amount = (selling_price.to_f - paid_amount.to_f)
    (amount >= 0 ? amount : 0).to_f
  end
  
  def paid_percent
    percent = ((paid_amount.to_f/selling_price.to_f)*100)
    percent > 100 ? 100 : percent
  end
  
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
  
  private
  def generate_token
    self.token = Digest::MD5.hexdigest(self.code) if self.code.present?
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
#  wholesale_price    :decimal(6, 2)
#  retail_price       :decimal(6, 2)
#  selling_price      :decimal(6, 2)
#  discount           :decimal(6, 3)
#  status             :string(255)      default("in_stock")
#  payment_status     :string(255)
#  description        :text
#  paid_amount        :decimal(6, 2)
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
