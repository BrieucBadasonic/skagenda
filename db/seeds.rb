require "open-uri"

puts "Cleaning DB"
User.destroy_all
Event.destroy_all
Timeslot.destroy_all
Band.destroy_all
Venue.destroy_all

puts "Creating 2 users"

user1 = User.new(username: "Brieuc",
                 email: "brieuc@gmail.com",
                 password: "123456")
user1.admin = true
user1.save!

user2 = User.new(username: "Nicolas",
                 email: "nicolas@gmail.com",
                 password: "123456")
# user2.admin = true
user2.save!

puts "2 users created"
puts "Creating 2 venues"

venue1 = Venue.new(name: "Magasin 4",
                   address: "Avenue du Port 51B, 1000 Bruxelles, Belgium")
venue1.save!

venue2 = Venue.new(name: "SO36",
                   address: "Oranienstraße 190, 10999 Berlin")
venue2.save!

puts "2 venues created"
puts "Creating 4 bands"

band1 = Band.new(name: "The Slackers")
band1.save!

band2 = Band.new(name: "The Pigeons")
band2.save!

band3 = Band.new(name: "The Aggrolites")
band3.save!

band4 = Band.new(name: "Crazy Baldhead")
band4.save!

puts "4 bands created"
puts "Creating 2 events"

event1 = Event.new(date: '2021-07-24',
                   price: '20',
                   venue: venue1,
                   user: user1)
event1.bands << band1
event1.bands << band2
event1.save!
file = URI.open('https://res.cloudinary.com/duogrvvdx/image/upload/v1619952376/moonstomp%20agenda/seed/test1_bbjnbo.jpg')
event1.photo.attach(io: file, filename: 'event.jpg', content_type: 'image/jpg')

event2 = Event.new(date: '2021-06-27',
                   price: '26',
                   venue: venue2,
                   user: user2)
event2.bands << band3
event2.bands << band4
event2.save!
file = URI.open('https://res.cloudinary.com/duogrvvdx/image/upload/v1619952366/moonstomp%20agenda/seed/test2_flyqbd.jpg')
event2.photo.attach(io: file, filename: 'event.jpg', content_type: 'image/jpg')

puts "2 events created"
