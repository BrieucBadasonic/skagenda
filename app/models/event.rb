class Event < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :timeslots
  has_many :bands, through: :timeslots
  has_one_attached :photo

  accepts_nested_attributes_for :venue
  accepts_nested_attributes_for :bands
end