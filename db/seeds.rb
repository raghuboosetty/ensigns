admin = Admin.where(email: 'admin@ensigns.com').exists?(conditions = :none)
if !admin
  puts "Seeding Admin..."
  Admin.create! email: 'admin@ensigns.com',
                password: 'admin1234',
                password_confirmation: 'admin1234',
                name: "Sneha",
                role: "super",
                gender: "f"
end

if Rails.env == 'development'
  if Customer.count.zero?
    puts "Seeding Customers..."
    10.times do |i|
      Customer.create name: [*('A'..'Z')].sample(8).join.capitalize,
                      email: ((0..8).map{('a'..'z').to_a[rand(26)]}.join + "@nomail.com"),
                      phone: rand(10 ** 10).to_s
    end
  end

  if Item.count.zero?
    puts "Seeding Items..."
    customers = Customer.all.pluck(:id)
    20.times do |i|
      rand_str = [*('A'..'Z')].sample(7).join + i.to_s
      Item.create token: Digest::MD5.hexdigest(rand_str),
                  size: Item::SIZES.keys.sample,
                  code: rand_str,
                  wholesale_price: rand(100.0...2000.99),
                  retail_price: rand(100.0...2000.99),
                  selling_price: rand(100.0...2000.99),
                  discount: rand(0.0...100.00),
                  status: Item::STATUSES.keys.sample,
                  payment_status: nil,
                  description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  paid_amount: rand(100.0...2000.99),
                  customer_id: customers.sample
                  
    end
  end
end