class ApplicationController < ActionController::Base
	before_action :set_background

	def set_background
		@bg_image = "bg_" + rand(1..4).to_s + ".jpg"
	end
end
