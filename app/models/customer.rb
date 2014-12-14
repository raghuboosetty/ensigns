class Customer < ActiveRecord::Base
  has_many :items
  
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
