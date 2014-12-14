class Customer < ActiveRecord::Base
  has_many :items

  validates :name, :email, :phone, presence: true
  validates :email, uniqueness: true, email: true
  validates :phone, numericality: { only_integer: true }


  def pending_amount
    paid_amount = items.sum(:paid_amount)
    selling_price = items.sum(:selling_price)
    amount = (selling_price - paid_amount)
    amount = (amount >= 0 ? amount : 0).to_f
  end
  
  def pending_percent
    paid_amount = items.sum(:paid_amount)
    selling_price = items.sum(:selling_price)
    if selling_price > 0
      percent = ((paid_amount.to_f/selling_price)*100)
      percent > 100 ? 100 : percent
    else
      nil
    end
  end

  class << self
    def select_options
      self.all.map{ |c| [c.name, c.id] }
    end
  end
end



# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :integer
#  created_at :datetime
#  updated_at :datetime
#
