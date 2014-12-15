class Image < ActiveRecord::Base
	belongs_to :case_log
	validates_presence_of :url, :title
	validates :url, url: true
end
