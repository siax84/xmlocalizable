require "application_system_test_case"

class SynchronizationsTest < ApplicationSystemTestCase
  setup do
    @synchronization = synchronizations(:one)
  end

  test "visiting the index" do
    visit synchronizations_url
    assert_selector "h1", text: "Synchronizations"
  end

  test "creating a Synchronization" do
    visit synchronizations_url
    click_on "New Synchronization"

    fill_in "Name", with: @synchronization.name
    click_on "Create Synchronization"

    assert_text "Synchronization was successfully created"
    click_on "Back"
  end

  test "updating a Synchronization" do
    visit synchronizations_url
    click_on "Edit", match: :first

    fill_in "Name", with: @synchronization.name
    click_on "Update Synchronization"

    assert_text "Synchronization was successfully updated"
    click_on "Back"
  end

  test "destroying a Synchronization" do
    visit synchronizations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Synchronization was successfully destroyed"
  end
end
