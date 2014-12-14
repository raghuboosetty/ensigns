class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  GENDERS = {m: "Male", f: "Female", o: "Other"}

  def role_name
   role == 'super' ? 'Super Admin' : 'Admin'
  end

end
