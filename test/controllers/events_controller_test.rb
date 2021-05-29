require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  user1 = User.new(username: "Brieuc",
                   email: "brieuc@gmail.com",
                   password: "123456")

  venue1 = Venue.new(name: "Magasin 4",
                     address: "Avenue du Port 51B, 1000 Bruxelles, Belgium")

  test "should not save an event without date and title" do
    event = Event.new
    assert !event.save
  end

  test "should not save an event without a date" do
    event = Event.new(price: 32, venue: venue1, user: user1)
    assert !event.save
  end

  test "should not save an event without a price" do
    event = Event.new(date: "2021-08-27", venue: venue1, user: user1)
    assert !event.save
  end

  test "should not save an event without a venue" do
    event = Event.new(date: "2021-08-27", price: "32", user: user1)
    assert !event.save
  end

  test "should not save an event without a user" do
    event = Event.new(date: "2021-08-27", price: "32", venue: venue1)
    assert !event.save
  end

  test "should save an event with date, price, venu and user" do
    event = Event.new(date: "2021-08-27", price: "32")
    event.venue = venue1
    event.user = user1
    assert event.save
  end

  test "should not save a second event with the same date/venue" do
    event1 = Event.new(date: "2021-08-27", price: "32", venue: venue1, user: user1)
    event1.save
    event2 = Event.new(date: "2021-08-27", price: "17", venue: venue1, user: user1)
    assert !event2.save
  end
end
