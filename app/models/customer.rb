class Customer < ActiveRecord::Base
  has_many :items
  
  validates :name, :email, :phone, presence: true  
  validates :email, uniqueness: true, email: true
  validates :phone, numericality: { only_integer: true }
  
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
