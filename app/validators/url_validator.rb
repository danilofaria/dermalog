require 'open-uri'
require 'net/http'

class UrlValidator < ActiveModel::EachValidator
print "\n so far so good \n"
  def validate_each(record, attribute, value)
    unless url_is_image?(value)
      record.errors[attribute] << (options[:message] || "invalid url")
    end
  end

  def url_is_image?(url)
  	print "\n so far so good 2!\n"
    url = URI.parse(url)
    Net::HTTP.start(url.host, url.port) do |http|
      return http.head(url.request_uri)['Content-Type'].start_with? 'image'
    end
  end

end