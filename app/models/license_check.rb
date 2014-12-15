require 'httparty'
require 'json'

class LicenseCheck
  include HTTParty

  # return constants
  VALID_LICENSE = 0
  INVALID_LICENSE = 1
  INVALID_STATE = 2
  INVALID_NAME = 3
  ERROR = -1


  base_uri 'http://api.doctoralia.com'

  def api_key
    # ENV['DOCTORALIA_API_KEY']
    return '208a918f'
  end

  def check_license(doctor)
    # querying the doctoralia API uing httparty
    response = self.class.get("/v1/br/professionals/#{doctor.license}?apiKey=#{api_key}", )

    # checking if the query was successful
    if response.success? == false
      return ERROR
    end

    # parsing the JSON response
    json_response = JSON.parse(response.body)

    # if success is not true, the license number provided is invalid
    if json_response['success'] != true
      return INVALID_LICENSE
    # checking if the provided state is valid. The state code is the last two characters of result.address.province
    elsif doctor.state.upcase != json_response['result']['addresses'][0]['province'].slice(-2,2).upcase
      return INVALID_STATE
    # checking if the name provided correspond to the name for the provided license 
    # additional conditions check for Dr. or Dra. prefix.
    elsif (doctor.name.upcase != json_response['result']['name'].upcase && doctor.name.upcase != json_response['result']['name'].upcase.slice(5..json_response['result']['name'].size) && doctor.name.upcase != json_response['result']['name'].upcase.slice(4..json_response['result']['name'].size))
      return INVALID_NAME
    else
      # if nothing above is invalid, then the information providade is valid
      return VALID_LICENSE
    end
  end
end