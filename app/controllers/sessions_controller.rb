class SessionsController < ApplicationController
	def new
	end

	def create
	  doctor = Doctor.find_by_license(params[:license])
	  if doctor && doctor.password == params[:password]
	    session[:user_id] = doctor.id
	    redirect_to root_url, notice: "Logged in!"
	  else
	    flash.now.alert = "License number or password is invalid"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, notice: "Logged out!"
	end
end

