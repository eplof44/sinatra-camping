class TripsController < ApplicationController

  get '/trips/new' do
   if logged_in?
    @user = current_user
    erb :'/trips/new'
   else
    redirect "/login"
  end
 end

 post '/trips' do
  @user = current_user
  if params[:date] == ""
   redirect "/trips/new"
  else
   @trip = Trip.create(name: params[:name], location: params[:location], site: params[:site], date: params[:date], summary: params[:summary])
   @trip.user_id = @user.id
   @trip.save
   redirect "/trips/#{@trip.id}"
  end
 end

 
end
