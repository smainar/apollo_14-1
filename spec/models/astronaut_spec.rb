require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many(:missions).through(:astronaut_missions)}
  end

  describe "class methods" do
    before(:each) do
      @neil = Astronaut.create!(name: "Neil Armstrong", age: 35, job: "Commander")
      @sally = Astronaut.create!(name: "Sally Ride", age: 40, job: "Captain")
      @john = Astronaut.create!(name: "John Glenn", age: 45, job: "Lieutenant")

      @astronauts = Astronaut.all

      @mission_1 = @neil.missions.create!(title: "Mercury 1", time_in_space: 1)
      @mission_2 = @neil.missions.create!(title: "Venus 2", time_in_space: 2)
      @mission_3 = @sally.missions.create!(title: "Mars 3", time_in_space: 3)
      @mission_4 = @sally.missions.create!(title: "Saturn 4", time_in_space: 4)
      @mission_5 = @john.missions.create!(title: "Uranus 5", time_in_space: 5)
      @mission_6 = @john.missions.create!(title: "Neptune 6", time_in_space: 6)
    end

    it "::average_age" do

      expect(@astronauts.average_age).to eq(40)
    end

    it "#alphabetize_missions" do

      expect(@neil.alphabetize_missions).to eq([@mission_1, @mission_2])
      expect(@sally.alphabetize_missions).to eq([@mission_3, @mission_4])
      expect(@john.alphabetize_missions).to eq([@mission_6, @mission_5])
    end
  end
end
