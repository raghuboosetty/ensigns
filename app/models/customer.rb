class Customer < ActiveRecord::Base
  has_many :items
  
  class << self
    def select_options
      self.all.map{ |c| [c.name, c.id] }
    end
  end
end
