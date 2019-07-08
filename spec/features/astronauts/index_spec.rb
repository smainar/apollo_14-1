require "rails_helper"

RSpec.describe "Astronaut Index Page", type: :feature do
  describe  "As a visitor" do
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

    it "I see a list of astronauts including their name, age, and job" do
      visit "/astronauts"

      within "#astronauts-#{@neil.id}" do
        expect(page).to have_content(@neil.name)
        expect(page).to have_content(@neil.age)
        expect(page).to have_content(@neil.job)
      end

      within "#astronauts-#{@sally.id}" do
        expect(page).to have_content(@sally.name)
        expect(page).to have_content(@sally.age)
        expect(page).to have_content(@sally.job)
      end

      within "#astronauts-#{@john.id}" do
        expect(page).to have_content(@john.name)
        expect(page).to have_content(@john.age)
        expect(page).to have_content(@john.job)
      end
    end

    it "I see the average age of all astronauts" do
      visit "/astronauts"

      expect(page).to have_content("Average Age: #{@astronauts.average_age}")
    end

    it "I see a list of the space missions' in alphabetical order for each astronaut" do
      visit "/astronauts"

      within "#astronauts-#{@neil.id}" do
        expect(page.all("li")[0]).to have_content(@mission_1.title)
        expect(page.all("li")[1]).to have_content(@mission_2.title)
      end

      within "#astronauts-#{@sally.id}" do
        expect(page.all("li")[0]).to have_content(@mission_3.title)
        expect(page.all("li")[1]).to have_content(@mission_4.title)
      end

      within "#astronauts-#{@john.id}" do
        expect(page.all("li")[0]).to have_content(@mission_6.title)
        expect(page.all("li")[1]).to have_content(@mission_5.title)
      end
    end
  end
end
