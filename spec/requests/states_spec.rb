require 'spec_helper'

describe "States page" do
  before do
    indiana = FactoryGirl.create(:state_with_dual_chamber, code: "IN", name: "Indiana")
    nebraska = FactoryGirl.create(:state_with_single_chamber, code: "NE", name: "Nebraska")
  end

  #context "Date" do
  #  it "show the date for any date in url" do
  #    visit "/states/in/2012/05/23"
  #    page.should have_content("Wednesday, May 23, 2012")
  #  end
  #end

  context "Indiana" do
    before do
      visit "/states/in"
    end

    it "shows a unique date, each day" do
      date = find("h2.date").text
      time_travel_to("tomorrow") do
        visit "/states/in"
        date.should_not == find("h2.date").text
      end
    end

    context "Rotation" do
      it "shows a different member on different days" do
        name = find(".member-name").text
        time_travel_to("tomorrow") do
          visit "/states/in"
          name.should_not == find(".member-name").text
        end
      end
    end
  end

  context "nebraska" do
    before do
      visit "/states/ne"
    end

    it "shows specific state" do
      page.should have_content("Nebraska")
    end

    it "shows name of member for state" do
      #page.should have_content("Joe Shmoe")
    end

    it "shows name of member for state" do
      #page.should have_content("Joe2 Shmoe2")
    end

    it "shows a unique date, each day" do
      date = find("h2.date").text
      time_travel_to("tomorrow") do
        visit "/states/ne"
        date.should_not == find("h2.date").text
      end
    end

    context "Rotation" do
      it "shows a different member on different days" do
        name = find(".member-name").text
        time_travel_to("tomorrow") do
          visit "/states/ne"
          name.should_not == find(".member-name").text
        end
      end
    end
  end

  context "Indiana" do
    before do
      visit "/states/in"
    end

    it "shows specific state" do
      page.should have_content("Indiana")
    end

    it "shows representative for state" do
      page.should have_content("Representative")
    end

    it "shows senator for state" do
      page.should have_content("Senator")
    end

    it "includes image of member" do
      page.should have_selector('img.head-shot')
    end

  end
end
