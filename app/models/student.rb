class Student < ApplicationRecord
  has_many :courses
  has_many :assignments
end
