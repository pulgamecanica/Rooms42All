require "application_system_test_case"

class ReservationsTest < ApplicationSystemTestCase
  setup do
    @reservation = reservations(:one)
  end

  test "visiting the index" do
    visit reservations_url
    assert_selector "h1", text: "Reservations"
  end

  test "creating a Reservation" do
    visit reservations_url
    click_on "New Reservation"

    fill_in "Attendees", with: @reservation.attendees
    fill_in "Email", with: @reservation.email
    fill_in "Reservation code", with: @reservation.reservation_code
    fill_in "Room", with: @reservation.room_id
    fill_in "Subject", with: @reservation.subject
    fill_in "T beginning", with: @reservation.t_beginning
    fill_in "T ending", with: @reservation.t_ending
    click_on "Create Reservation"

    assert_text "Reservation was successfully created"
    click_on "Back"
  end

  test "updating a Reservation" do
    visit reservations_url
    click_on "Edit", match: :first

    fill_in "Attendees", with: @reservation.attendees
    fill_in "Email", with: @reservation.email
    fill_in "Reservation code", with: @reservation.reservation_code
    fill_in "Room", with: @reservation.room_id
    fill_in "Subject", with: @reservation.subject
    fill_in "T beginning", with: @reservation.t_beginning
    fill_in "T ending", with: @reservation.t_ending
    click_on "Update Reservation"

    assert_text "Reservation was successfully updated"
    click_on "Back"
  end

  test "destroying a Reservation" do
    visit reservations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reservation was successfully destroyed"
  end
end
