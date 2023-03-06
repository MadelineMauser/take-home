# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.delete_all
Tea.delete_all
Subscription.delete_all
TeaSubscription.delete_all

Customer.create!(first_name: 'Fred', last_name: 'Williams', email: 'fredw@example.com', address: '123 Example Place')
Customer.create!(first_name: 'Irma', last_name: 'Redd', email: 'irmar@example.com', address: '456 Example Way')
Tea.create!(title: 'Spicy Chai', description: 'Extra spicy with cinnamon.', temperature: 212, brew_time: 4)
Tea.create!(title: 'Uncommon Chai', description: 'Uses a secret blend of spices.', temperature: 200, brew_time: 3)
Tea.create!(title: 'Morning Black', description: 'Black tea with high caffeine.', temperature: 212, brew_time: 4)
Tea.create!(title: 'English Breakfast', description: 'Classic breakfast tea.', temperature: 200, brew_time: 3)
Subscription.create!(customer_id: @customer_1.id, title: 'Chai Delight', price: 20, frequency: 3)
Subscription.create!(customer_id: @customer_1.id, title: 'Dawn Risers', price: 20, frequency: 3)
Subscription.create!(customer_id: @customer_2.id, title: 'Solo Chai', price: 20, frequency: 3)
TeaSubscription.create!(tea_id: @tea_1.id, subscription_id: @subscription_1.id)
TeaSubscription.create!(tea_id: @tea_2.id, subscription_id: @subscription_1.id)
TeaSubscription.create!(tea_id: @tea_3.id, subscription_id: @subscription_2.id)
TeaSubscription.create!(tea_id: @tea_4.id, subscription_id: @subscription_2.id)
TeaSubscription.create!(tea_id: @tea_1.id, subscription_id: @subscription_3.id)