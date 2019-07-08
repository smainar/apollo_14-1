class Astronaut < ApplicationRecord
  validates_presence_of :name, :age, :job

  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions

  def self.average_age
    self.average(:age)
  end

  def alphabetize_missions
    missions.order(:title)
  end
end
