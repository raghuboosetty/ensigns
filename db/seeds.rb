admin = Admin.where(email: 'admin@ensigns.com').exists?(conditions = :none)
if !admin
  Admin.create! email: 'admin@ensigns.com',
                password: 'admin1234',
                password_confirmation: 'admin1234',
                name: "Sneha",
                role: "super",
                gender: "f"
end