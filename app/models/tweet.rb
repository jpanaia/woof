class Tweet < ActiveRecord::Base

	belongs_to :user

	validates :message, presence: true
	validates :message, length: {maximum: 160, too_long: "We gave you 20 more characters than Twitter and you want even more?!"}
	
end
