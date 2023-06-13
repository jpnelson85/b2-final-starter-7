module ApplicationHelper

  def retrieve_holidays
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/us")
    j_response = JSON.parse(response.body, symbolize_names: true)
    j_response[0..2]
  end

end
