require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  test "visiting the index, checking H1 and button" do
    visit root_url

    assert_selector "h1", text: "Moonstomp Agenda"
    assert_selector "p", text: "Agenda"
  end

  test "visiting the index, checking there is no navbar" do
    visit root_url

    assert_selector ".nav-title", text: "Moonstomp Agenda", count: 0
  end

  test "click on agenda bring us to events#index" do
    visit root_url

    click_on "Agenda"
    assert_selector ".nav-title", text: "Moonstomp Agenda"
  end
end
